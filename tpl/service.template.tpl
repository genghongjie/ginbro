package service

import (
	"{{.OutPackage}}/models"
	"{{.OutPackage}}/misc/util"
)

type {{.ModelName}}Service struct {
}

func New{{.ModelName}}Service() *{{.ModelName}}Service {
	return &{{.ModelName}}Service{}
}

//All
func (s *{{.ModelName}}Service) All(query *models.PaginationQuery) (pagination *models.PageResult{{.ModelName}}, err error) {
	mdl := models.{{.ModelName}}{}
	list, total, err := mdl.All(query)
	pagination = &models.PageResult{{.ModelName}}{
        List: list,
        PageResult: models.PageResult{
            Total:    int(total),
            Page:     util.GetPage(query.Page),
            PageSize: util.GetLimit(query.PageSize),
        },
    }
	return
}

//One
func (s *{{.ModelName}}Service) One(id int) (one *models.{{.ModelName}}, err error) {
	var mdl models.{{.ModelName}}
	mdl.Id = id
	one, err = mdl.One()
	return
}
//First
func (s *{{.ModelName}}Service) First(mdl models.{{.ModelName}}) (one *models.{{.ModelName}}, err error) {
	one, err = mdl.First()
	return
}
//Create
func (s *{{.ModelName}}Service) Create(mdl *models.{{.ModelName}}) (err error) {
	err = mdl.Create()
	return
}

//Update
func (s *{{.ModelName}}Service) Update(mdl models.{{.ModelName}}) (err error) {
	err = mdl.Update()
	return
}

//Delete
func (s *{{.ModelName}}Service) Delete(mdl models.{{.ModelName}}) (err error) {
	err = mdl.Delete()
	return
}
//BatchDelete
func (s *{{.ModelName}}Service) BatchDelete(md models.{{.ModelName}}DeleteInputs) (err error) {
	mdl := models.{{.ModelName}}{}
	err = mdl.BatchDelete(md)
	return
}

//Delete by columns
func (s *{{.ModelName}}Service) DeleteByColumns(mdl models.{{.ModelName}}) (err error) {
	return mdl.DeleteByColumns()
}

//List
func (s *{{.ModelName}}Service) List(mdl models.{{.ModelName}}) (list *[]models.{{.ModelName}}, err error) {
	list, err = mdl.List()
	return
}
//Count
func (s *{{.ModelName}}Service) Count(mdl models.{{.ModelName}}) (count int, err error) {
	count, err = mdl.Count()
	return
}
