package models

import (
	"errors"
	"time"
	{{if .IsAuthTable}}"fmt"
	"github.com/spf13/viper"
	"golang.org/x/crypto/bcrypt"
	"github.com/sirupsen/logrus"
	{{end}}
)

//{{.ModelName}}
type {{.ModelName}} struct {
	{{range .Columns}}
	{{.ModelTag}}{{end}}
}

//{{.ModelName}}CreateInput
type {{.ModelName}}CreateInput struct {
	{{range .Columns}}
    {{if and (ne .ColumnName "id") (ne .ColumnName "created_at") (ne .ColumnName "updated_at") (ne .ColumnName "deleted_at")  }}
    {{.ModelTag}}
    {{end}}
    {{end}}
}

//{{.ModelName}}UpdateInput
type {{.ModelName}}UpdateInput struct {
	{{range .Columns}}

        {{if and (ne .ColumnName "created_at") (ne .ColumnName "updated_at") (ne .ColumnName "deleted_at")  }}
        {{.ModelTag}}
        {{end}}
    {{end}}
}
//{{.ModelName}} batch delete
type {{.ModelName}}DeleteInputs struct {
	List []int `json:"list" comment:"ID列表"`
}
type PageResult{{.ModelName}} struct {
	PageResult
	List *[]{{.ModelName}} `json:"list"`
}

//TableName
func (m *{{.ModelName}}) TableName() string {
	return "{{.TableName}}"
}
//One
func (m *{{.ModelName}}) One() (one *{{.ModelName}}, err error) {
	one = &{{.ModelName}}{}
	err = crudOne(m, one)
	return
}
//First
func (m *{{.ModelName}}) First() (one *{{.ModelName}}, err error) {
	one = &{{.ModelName}}{}
    err = crudFirst(m, one)
    if err != nil {
        one = nil
    }
	return
}
//All
func (m *{{.ModelName}}) All(q *PaginationQuery) (list *[]{{.ModelName}}, total uint, err error) {
	list = &[]{{.ModelName}}{}
	total, err = crudAll(m, q, list)
	return
}
//Update
func (m *{{.ModelName}}) Update() (err error) {
	where := {{.ModelName}}{Id: m.Id}
	m.Id = 0
	{{if .IsAuthTable }}m.makePassword()
	{{end}}
	return crudUpdate(m, where)
}
//Create
func (m *{{.ModelName}}) Create() (err error) {
    {{if .IsAuthTable }}m.makePassword()
    {{end}}
	return db.Create(m).Error
}
//Delete
func (m *{{.ModelName}}) Delete() (err error) {
	if m.Id == 0 {
		return errors.New("resource must not be empty value")
	}
	return crudDelete(m)
}


//Batch Delete
func (m *{{.ModelName}}) BatchDelete(md {{.ModelName}}DeleteInputs) (err error) {
	tx := db.Begin()
	defer func() {
		if err != nil {
			tx.Rollback()
		} else {
			tx.Commit()
		}
	}()
	for _, v := range md.List {
		mInput := {{.ModelName}}{}
		mInput.Id = v
		err = tx.Delete(mInput).Error
	}
	if err != nil {
		logger.Errorf("批量删除 {{.ModelName}} 失败，失败原因%s", err.Error())
		return
	}
	return
}


//DeleteByColumns
func (m *{{.ModelName}}) DeleteByColumns() (err error) {
	dbTmp := db.Where(m).Delete(m)
	return dbTmp.Error
}
//List
func (m *{{.ModelName}}) List() (list *[]{{.ModelName}}, err error) {
	list = &[]{{.ModelName}}{}
	err = crudList(m, list)
	return
}
//Count
func (m *{{.ModelName}}) Count() (count int, err error) {
	dbTmp := db.Model(&{{.ModelName}}{}).Where(m).Count(&count)

	if err = dbTmp.Error; err != nil {
		return
	}
	return count, nil
}


{{if .IsAuthTable }}
//Login
func (m *{{.ModelName}}) Login(ip string) (*jwtObj, error) {
	m.Id = ""
	if m.{{.PasswordPropertyName}} == "" {
		return nil, errors.New("password is required")
	}
	inputPassword := m.{{.PasswordPropertyName}}
	m.{{.PasswordPropertyName}} = ""
	loginTryKey := "login:" + ip
	loginRetries, _ := mem.GetUint(loginTryKey)
	if loginRetries > uint(viper.GetInt("app.login_try")) {
		memExpire := viper.GetInt("app.mem_expire_min")
		return nil, fmt.Errorf("for too many wrong login retries the %s will ban for login in %d minitues", ip, memExpire)
	}
	//you can implement more detailed login retry rule
	//for i don't know what your login username i can't implement the ip+username rule in my boilerplate project
	// about username and ip retry rule

	err := db.Where(m).First(&m).Error
	if err != nil {
		//username fail ip retries add 5
		loginRetries = loginRetries + 5
		mem.Set(loginTryKey, loginRetries)
		return nil, err
	}
	//password is set to bcrypt check
	if err := bcrypt.CompareHashAndPassword([]byte(m.{{.PasswordPropertyName}}), []byte(inputPassword)); err != nil {
		// when password failed reties will add 1
		loginRetries = loginRetries + 1
		mem.Set(loginTryKey, loginRetries)
		return nil, err
	}
    m.{{.PasswordPropertyName}} = ""
	key := fmt.Sprintf("login:%d", m.Id)

	//save login user  into the memory store

    data ,err := jwtGenerateToken(m)
    mem.Set(key, data)
    return data,err
}

func (m *{{.ModelName}}) makePassword() {
	if m.{{.PasswordPropertyName}} != "" {
		if bytes, err := bcrypt.GenerateFromPassword([]byte(m.{{.PasswordPropertyName}}), bcrypt.DefaultCost); err != nil {
			logrus.WithError(err).Error("bcrypt making password is failed")
		} else {
			m.{{.PasswordPropertyName}} = string(bytes)
		}
	}
}
{{end}}