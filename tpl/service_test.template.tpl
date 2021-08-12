package service

import (
	"reflect"
	"testing"
	"time"

	"github.com/pkg/errors"
	"{{.OutPackage}}/models"

	. "github.com/agiledragon/gomonkey"
	. "github.com/smartystreets/goconvey/convey"
)
{{range .Tables}}
func Test{{.ModelName}}AllSuccess(t *testing.T) {
	o := New{{.ModelName}}Service()
	var mdl *models.{{.ModelName}}
	var id0="a41c9d9c-674d-4593-abdc-8c854e871c7c"
	var id1="a41c9d9c-674d-abdc-4593-8c854e871c7c"
	var _time = time.Now()
	list := make([]models.{{.ModelName}}, 2)
	list[0] = models.{{.ModelName}}{ {{range .Columns}}{{.ModelProp}}: {{if eq .ModelProp "Id"}}id0{{else}} {{if eq .ModelType "string"}}""{{else if eq .ModelType "*time.Time"}}&_time{{else if eq .ModelType "int"}}0{{else if eq .ModelType "float32"}}0{{end}}{{end}} ,{{end}} }
	list[1] = models.{{.ModelName}}{ {{range .Columns}}{{.ModelProp}}: {{if eq .ModelProp "Id"}}id1{{else}} {{if eq .ModelType "string"}}""{{else if eq .ModelType "*time.Time"}}&_time{{else if eq .ModelType "int"}}0{{else if eq .ModelType "float32"}}0{{end}}{{end}} ,{{end}} }
	Convey("Test{{.ModelName}}AllSuccess", t, func() {
		patches := ApplyMethod(reflect.TypeOf(mdl), "All", func(_ *models.{{.ModelName}}, _ *models.PaginationQuery) (*[]models.{{.ModelName}}, uint, error) {
			return &list, 2, nil
		})
		defer patches.Reset()
		query := models.PaginationQuery{}
		query.Page = 1
		query.PageSize = 10
		p, err := o.All(&query)
		So(p.List, ShouldNotBeNil)
		So(p.Total, ShouldEqual, 2)
		So(err, ShouldBeNil)
		So((*p.List)[0].Id, ShouldEqual, id0)
		So((*p.List)[1].Id, ShouldEqual, id1)
	})
}

func Test{{.ModelName}}AllDbError(t *testing.T) {
	o := New{{.ModelName}}Service()
	var mdl *models.{{.ModelName}}
	var id0="a41c9d9c-674d-4593-abdc-8c854e871c7c"
	var id1="a41c9d9c-674d-abdc-4593-8c854e871c7c"
	var _time = time.Now()
	list := make([]models.{{.ModelName}}, 2)
	list[0] = models.{{.ModelName}}{ {{range .Columns}}{{.ModelProp}}: {{if eq .ModelProp "Id"}}id0{{else}} {{if eq .ModelType "string"}}""{{else if eq .ModelType "*time.Time"}}&_time{{else if eq .ModelType "int"}}0{{else if eq .ModelType "float32"}}0{{end}}{{end}} ,{{end}} }
	list[1] = models.{{.ModelName}}{ {{range .Columns}}{{.ModelProp}}: {{if eq .ModelProp "Id"}}id1{{else}} {{if eq .ModelType "string"}}""{{else if eq .ModelType "*time.Time"}}&_time{{else if eq .ModelType "int"}}0{{else if eq .ModelType "float32"}}0{{end}}{{end}} ,{{end}} }
	Convey("Test{{.ModelName}}AllDbError", t, func() {
		patches := ApplyMethod(reflect.TypeOf(mdl), "All", func(_ *models.{{.ModelName}}, _ *models.PaginationQuery) (*[]models.{{.ModelName}}, uint, error) {
			return nil, 0, errors.New("db error")
		})
		defer patches.Reset()
		query := models.PaginationQuery{}
		query.Page = 1
		query.PageSize = 10
		p, err := o.All(&query)
		So(err, ShouldNotBeNil)
		So(err.Error(), ShouldEqual, "db error")
		So(p.Total, ShouldEqual, 0)
		So(p.List, ShouldBeNil)
	})
}

func Test{{.ModelName}}OneSuccess(t *testing.T) {
	o := New{{.ModelName}}Service()
	var mdl *models.{{.ModelName}}
	var id="a41c9d9c-674d-4593-abdc-8c854e871c7c"
	var _time = time.Now()
	{{.HandlerName}} := models.{{.ModelName}}{ {{range .Columns}}{{.ModelProp}}: {{if eq .ModelProp "Id"}}id{{else}} {{if eq .ModelType "string"}}""{{else if eq .ModelType "*time.Time"}}&_time{{else if eq .ModelType "int"}}0{{else if eq .ModelType "float32"}}0{{end}}{{end}} ,{{end}} }
	Convey("Test{{.ModelName}}OneSuccess", t, func() {
		patches := ApplyMethod(reflect.TypeOf(mdl), "One", func(_ *models.{{.ModelName}}) (*models.{{.ModelName}}, error) {
			return &{{.HandlerName}}, nil
		})
		defer patches.Reset()

		one, err := o.One(id)
		So(one, ShouldNotBeNil)
		So(one.Id, ShouldEqual, id)
		So(err, ShouldBeNil)
	})
}

func Test{{.ModelName}}OneNotFound(t *testing.T) {
	o := New{{.ModelName}}Service()
	var mdl *models.{{.ModelName}}
	var id="a41c9d9c-674d-4593-abdc-8c854e871c7c"
	Convey("Test{{.ModelName}}OneNotFound", t, func() {
		patches := ApplyMethod(reflect.TypeOf(mdl), "One", func(_ *models.{{.ModelName}}) (*models.{{.ModelName}}, error) {
			return nil, errors.New("resource is not found")
		})
		defer patches.Reset()

		one, err := o.One(id)
		So(err, ShouldNotBeNil)
		So(err.Error(), ShouldEqual, "resource is not found")
		So(one, ShouldBeNil)
	})
}

func Test{{.ModelName}}FirstSuccess(t *testing.T) {
	o := New{{.ModelName}}Service()
	var mdl *models.{{.ModelName}}
	var id="a41c9d9c-674d-4593-abdc-8c854e871c7c"
	var _time = time.Now()
	{{.HandlerName}} := models.{{.ModelName}}{ {{range .Columns}}{{.ModelProp}}: {{if eq .ModelProp "Id"}}id{{else}} {{if eq .ModelType "string"}}""{{else if eq .ModelType "*time.Time"}}&_time{{else if eq .ModelType "int"}}0{{else if eq .ModelType "float32"}}0{{end}}{{end}} ,{{end}} }
	Convey("Test{{.ModelName}}FirstSuccess", t, func() {
		patches := ApplyMethod(reflect.TypeOf(mdl), "First", func(_ *models.{{.ModelName}}) (*models.{{.ModelName}}, error) {
			return &{{.HandlerName}}, nil
		})
		defer patches.Reset()

		one, err := o.First(id)
		So(one, ShouldNotBeNil)
		So(one.Id, ShouldEqual, id)
		So(err, ShouldBeNil)
	})
}

func Test{{.ModelName}}FirstNotFound(t *testing.T) {
	o := New{{.ModelName}}Service()
	var mdl *models.{{.ModelName}}
	var id="a41c9d9c-674d-4593-abdc-8c854e871c7c"
	Convey("Test{{.ModelName}}FirstNotFound", t, func() {
		patches := ApplyMethod(reflect.TypeOf(mdl), "First", func(_ *models.{{.ModelName}}) (*models.{{.ModelName}}, error) {
			return nil, errors.New("resource is not found")
		})
		defer patches.Reset()

		one, err := o.First(id)
		So(err, ShouldNotBeNil)
		So(err.Error(), ShouldEqual, "resource is not found")
		So(one, ShouldBeNil)
	})
}

func Test{{.ModelName}}CreateOneSuccess(t *testing.T) {
	o := New{{.ModelName}}Service()
	var mdl *models.{{.ModelName}}
	var id="a41c9d9c-674d-4593-abdc-8c854e871c7c"
	var _time = time.Now()
	{{.HandlerName}} := models.{{.ModelName}}{ {{range .Columns}}{{.ModelProp}}: {{if eq .ModelProp "Id"}}id{{else}} {{if eq .ModelType "string"}}""{{else if eq .ModelType "*time.Time"}}&_time{{else if eq .ModelType "int"}}0{{else if eq .ModelType "float32"}}0{{end}}{{end}} ,{{end}} }
	Convey("Test{{.ModelName}}CreateOneSuccess", t, func() {
		patches := ApplyMethod(reflect.TypeOf(mdl), "Create", func(_ *models.{{.ModelName}}) error {
			return nil
		})
		defer patches.Reset()

		err := o.Create(&{{.HandlerName}})
		So(err, ShouldBeNil)
	})
}

func Test{{.ModelName}}CreateDbError(t *testing.T) {
	o := New{{.ModelName}}Service()
	var mdl *models.{{.ModelName}}
	var id="a41c9d9c-674d-4593-abdc-8c854e871c7c"
	var _time = time.Now()
	Convey("Test{{.ModelName}}CreateDbError", t, func() {
		patches := ApplyMethod(reflect.TypeOf(mdl), "Create", func(_ *models.{{.ModelName}}) error {
			return errors.New("db error")
		})
		defer patches.Reset()

		{{.HandlerName}} := models.{{.ModelName}}{ {{range .Columns}}{{.ModelProp}}: {{if eq .ModelProp "Id"}}id{{else}} {{if eq .ModelType "string"}}""{{else if eq .ModelType "*time.Time"}}&_time{{else if eq .ModelType "int"}}0{{else if eq .ModelType "float32"}}0{{end}}{{end}} ,{{end}} }

		err := o.Create(&{{.HandlerName}})
		So(err, ShouldNotBeNil)
		So(err.Error(), ShouldEqual, "db error")
	})
}

func Test{{.ModelName}}UpdateOneSuccess(t *testing.T) {
	o := New{{.ModelName}}Service()
	var mdl *models.{{.ModelName}}
	var id="a41c9d9c-674d-4593-abdc-8c854e871c7c"
	var _time = time.Now()
	{{.HandlerName}} := models.{{.ModelName}}{ {{range .Columns}}{{.ModelProp}}: {{if eq .ModelProp "Id"}}id{{else}} {{if eq .ModelType "string"}}""{{else if eq .ModelType "*time.Time"}}&_time{{else if eq .ModelType "int"}}0{{else if eq .ModelType "float32"}}0{{end}}{{end}} ,{{end}} }
	Convey("Test{{.ModelName}}UpdateOneSuccess", t, func() {
		patches := ApplyMethod(reflect.TypeOf(mdl), "Update", func(_ *models.{{.ModelName}}) error {
			return nil
		})
		defer patches.Reset()

		err := o.Update({{.HandlerName}})
		So(err, ShouldBeNil)
	})
}

func Test{{.ModelName}}UpdateDbError(t *testing.T) {
	o := New{{.ModelName}}Service()
	var mdl *models.{{.ModelName}}
	var id="a41c9d9c-674d-4593-abdc-8c854e871c7c"
	var _time = time.Now()
	Convey("Test{{.ModelName}}UpdateDbError", t, func() {
		patches := ApplyMethod(reflect.TypeOf(mdl), "Update", func(_ *models.{{.ModelName}}) error {
			return errors.New("id is invalid and resource is not found")
		})
		defer patches.Reset()

		{{.HandlerName}} := models.{{.ModelName}}{ {{range .Columns}}{{.ModelProp}}: {{if eq .ModelProp "Id"}}id{{else}} {{if eq .ModelType "string"}}""{{else if eq .ModelType "*time.Time"}}&_time{{else if eq .ModelType "int"}}0{{else if eq .ModelType "float32"}}0{{end}}{{end}} ,{{end}} }

		err := o.Update({{.HandlerName}})
		So(err, ShouldNotBeNil)
		So(err.Error(), ShouldEqual, "id is invalid and resource is not found")
	})
}

func Test{{.ModelName}}DeleteSuccess(t *testing.T) {
	o := New{{.ModelName}}Service()
	var mdl *models.{{.ModelName}}
	var id="a41c9d9c-674d-4593-abdc-8c854e871c7c"
	var _time = time.Now()
	Convey("Test{{.ModelName}}DeleteSuccess", t, func() {
		patches := ApplyMethod(reflect.TypeOf(mdl), "Delete", func(_ *models.{{.ModelName}}) error {
			return nil
		})
		defer patches.Reset()

		{{.HandlerName}} := models.{{.ModelName}}{ {{range .Columns}}{{.ModelProp}}: {{if eq .ModelProp "Id"}}id{{else}} {{if eq .ModelType "string"}}""{{else if eq .ModelType "*time.Time"}}&_time{{else if eq .ModelType "int"}}0{{else if eq .ModelType "float32"}}0{{end}}{{end}} ,{{end}} }
		err := o.Delete({{.HandlerName}})

		So(err, ShouldBeNil)
	})
}

func Test{{.ModelName}}DeleteNotFound(t *testing.T) {
	o := New{{.ModelName}}Service()
	var mdl *models.{{.ModelName}}
	var id="a41c9d9c-674d-4593-abdc-8c854e871c7c"
	var _time = time.Now()
	Convey("Test{{.ModelName}}DeleteNotFound", t, func() {
		patches := ApplyMethod(reflect.TypeOf(mdl), "Delete", func(_ *models.{{.ModelName}}) error {
			return errors.New("resource is not found")
		})
		defer patches.Reset()

		{{.HandlerName}} := models.{{.ModelName}}{ {{range .Columns}}{{.ModelProp}}: {{if eq .ModelProp "Id"}}id{{else}} {{if eq .ModelType "string"}}""{{else if eq .ModelType "*time.Time"}}&_time{{else if eq .ModelType "int"}}0{{else if eq .ModelType "float32"}}0{{end}}{{end}} ,{{end}} }
		err := o.Delete({{.HandlerName}})

		So(err, ShouldNotBeNil)
		So(err.Error(), ShouldEqual, "resource is not found")
	})
}

func Test{{.ModelName}}DeleteByColumnsSuccess(t *testing.T) {
	o := New{{.ModelName}}Service()
	var mdl *models.{{.ModelName}}
	var id="a41c9d9c-674d-4593-abdc-8c854e871c7c"
	var _time = time.Now()
	Convey("Test{{.ModelName}}DeleteByColumnsSuccess", t, func() {
		patches := ApplyMethod(reflect.TypeOf(mdl), "DeleteByColumns", func(_ *models.{{.ModelName}}) error {
			return nil
		})
		defer patches.Reset()

		{{.HandlerName}} := models.{{.ModelName}}{ {{range .Columns}}{{.ModelProp}}: {{if eq .ModelProp "Id"}}id{{else}} {{if eq .ModelType "string"}}""{{else if eq .ModelType "*time.Time"}}&_time{{else if eq .ModelType "int"}}0{{else if eq .ModelType "float32"}}0{{end}}{{end}} ,{{end}} }
		err := o.DeleteByColumns({{.HandlerName}})

		So(err, ShouldBeNil)
	})
}

func Test{{.ModelName}}DeleteByColumnsDbError(t *testing.T) {
	o := New{{.ModelName}}Service()
	var mdl *models.{{.ModelName}}
	var id="a41c9d9c-674d-4593-abdc-8c854e871c7c"
	var _time = time.Now()
	Convey("Test{{.ModelName}}DeleteByColumnsDbError", t, func() {
		patches := ApplyMethod(reflect.TypeOf(mdl), "DeleteByColumns", func(_ *models.{{.ModelName}}) error {
			return errors.New("db error")
		})
		defer patches.Reset()

		{{.HandlerName}} := models.{{.ModelName}}{ {{range .Columns}}{{.ModelProp}}: {{if eq .ModelProp "Id"}}id{{else}} {{if eq .ModelType "string"}}""{{else if eq .ModelType "*time.Time"}}&_time{{else if eq .ModelType "int"}}0{{else if eq .ModelType "float32"}}0{{end}}{{end}} ,{{end}} }
		err := o.DeleteByColumns({{.HandlerName}})

		So(err, ShouldNotBeNil)
		So(err.Error(), ShouldEqual, "db error")
	})
}
{{end}}