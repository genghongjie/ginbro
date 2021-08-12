package v1

import (
	"{{.OutPackage}}/models"
	"github.com/gin-gonic/gin"
	"{{.OutPackage}}/service"
	"{{.OutPackage}}/entity/constants"
)

//group{{.ModelName}}ApiV1  := r.Group("/api/v1")
//group{{.ModelName}}ApiV1.Use(jwt.JWT())
//{
    //group{{.ModelName}}ApiV1.GET("{{.ResourceName}}s",{{if .IsAuthTable}}jwtMiddleware,{{end}} v1.{{.ModelName}}All)
    //group{{.ModelName}}ApiV1.GET("{{.ResourceName}}s/:id", {{if .IsAuthTable}}jwtMiddleware,{{end}} v1.{{.ModelName}}One)
    //group{{.ModelName}}ApiV1.POST("{{.ResourceName}}s", {{if .IsAuthTable}}jwtMiddleware,{{end}} v1.{{.ModelName}}Create)
    //group{{.ModelName}}ApiV1.PUT("{{.ResourceName}}s", {{if .IsAuthTable}}jwtMiddleware,{{end}} v1.{{.ModelName}}Update)
    //group{{.ModelName}}ApiV1.DELETE("{{.ResourceName}}s/:id", {{if .IsAuthTable}}jwtMiddleware,{{end}} v1.{{.ModelName}}Delete)
    //group{{.ModelName}}ApiV1.DELETE("{{.ResourceName}}s-batch", {{if .IsAuthTable}}jwtMiddleware,{{end}} v1.{{.ModelName}}BatchDelete)
//}
//All
// @description Create {{.ResourceName}} 列表 分页
// @Summary  All {{.ResourceName}} 列表 分页
// @Accept  json
// @Param token header string true "token"
// @Param where query string false "column:compare:value will use sql LIKE for search eg: created_at:gt:2019-04-24|created_at:lt:2019-04-25 will where created_at > '2019-04-24' and created_at < '2019-04-25' eg2: name:like:eric will where name LIKE ‘%eric%’ eg3:  model,serial_number:likeor:hank will ((`model` like ''%hank%'') OR (`serial_number` like ''%hank%'')), eg4:  user_id:in:1,2,3 will user_id in ("1","2","3")；compare：eq,neq,in,gt,gte,lt,lte,like,likeor"
// @Param fields query string false "{$tableColumn},{$tableColumn}…"
// @Param order query string false "eg: id desc, name desc"
// @Param page query int false "page"
// @Param pageSize query int false "pageSize"
// @Success 200 {object} models.PageResult{{.ModelName}}
// @Failure 400 {object} e.Message
// @Failure 500 {object} e.Message
// @Router /api/v1/{{.ResourceName}}s [get]
func {{.ModelName}}All(c *gin.Context) {
	query := &models.PaginationQuery{}
	err := c.ShouldBindQuery(query)
	if handleRequestError(c, err, constants.CodeParamsError) {
        return
    }
	pagination, err := service.New{{.ModelName}}Service().All(query)
	if handleError(http.StatusInternalServerError, c, err, constants.CodeServerError) {
        return
    }
	jsonPagination(c, pagination)
}

//One
// @description Create {{.ResourceName}} 详情
// @Summary  One {{.ResourceName}} 详情
// @Accept  json
// @Param token header string true "token"
// @Param id path int true "id"
// @Success 200 {object} models.{{.ModelName}}
// @Failure 400 {object} e.Message
// @Failure 500 {object} e.Message
// @Router /api/v1/{{.ResourceName}}s/{id} [get]
func {{.ModelName}}One(c *gin.Context) {
	id, err := strconv.Atoi(c.Param("id"))
    if handleRequestError(c, err) {
        return
    }
    data, err := service.New{{.ModelName}}Service().One(id)
	if handleError(http.StatusNotFound, c, err) {
		return
	}
	jsonObject(c, data)
}
//Create
// @description Create {{.ResourceName}} 创建
// @Summary Create {{.ResourceName}} 创建
// @Produce  json
// @Accept json
// @Param token header string true "token"
// @Param data body models.{{.ModelName}}CreateInput  true "models.{{.ModelName}}CreateInput"
// @Success 200 {object} models.{{.ModelName}}
// @Failure 400 {object} e.Message
// @Failure 500 {object} e.Message
// @Router /api/v1/{{.ResourceName}}s [post]
func {{.ModelName}}Create(c *gin.Context) {
	var mdlInput models.{{.ModelName}}CreateInput
	err := c.ShouldBind(&mdlInput)
	if handleRequestError(c, err, constants.CodeParamsError) {
		return
	}
	//TODO Parameter Validation
	mdl := models.{{.ModelName}}{}
	//TODO Parameter Receive
	err = service.New{{.ModelName}}Service().Create(&mdl)
	if handleError(http.StatusInternalServerError, c, err, constants.CodeServerError) {
		return
	}
	jsonObject(c, mdl)
}
//Update
// @description Update {{.ResourceName}} 修改
// @Summary Update {{.ResourceName}} 修改
// @Produce  json
// @Accept json
// @Param token header string true "token"
// @Param data body models.{{.ModelName}}UpdateInput  true "models.{{.ModelName}}UpdateInput"
// @Success 200 {object} e.Message
// @Failure 400 {object} e.Message
// @Failure 500 {object} e.Message
// @Router /api/v1/{{.ResourceName}}s [put]
func {{.ModelName}}Update(c *gin.Context) {
	var mdlInput models.{{.ModelName}}UpdateInput
	err := c.ShouldBind(&mdlInput)
	if handleRequestError(c, err, constants.CodeParamsError) {
		return
	}
	//TODO Parameter Validation
	if mdlInput.Id == 0 {
        handleRequestError(c, err, constants.CodeParamsError)
        return
    }
	mdl := models.{{.ModelName}}{}
    mdl.Id = mdlInput.Id
	//TODO Parameter Receive
	err = service.New{{.ModelName}}Service().Update(mdl)
	if handleError(http.StatusInternalServerError, c, err, constants.CodeServerError) {
		return
	}
	jsonSuccess(c)
}
//Delete
// @description Delete {{.ResourceName}} 删除
// @Summary Delete {{.ResourceName}}  删除
// @Produce  json
// @Accept json
// @Param token header string true "token"
// @Param id path int true "id"
// @Success 200 {object} e.Message
// @Failure 400 {object} e.Message
// @Failure 500 {object} e.Message
// @Router /api/v1/{{.ResourceName}}s/{id} [delete]
func {{.ModelName}}Delete(c *gin.Context) {
	var mdl models.{{.ModelName}}
	var err error
	mdl.Id, err = strconv.Atoi(c.Param("id"))
    if handleRequestError(c, err) {
        return
    }
	err = service.New{{.ModelName}}Service().Delete(mdl)
	if handleError(http.StatusInternalServerError, c, err, constants.CodeServerError) {
		return
	}
	jsonSuccess(c)
}


//Batch delete
// @description Delete {{.ResourceName}} 批量删除
// @Summary Batch Delete {{.ResourceName}} 批量删除
// @Produce  json
// @Accept json
// @Param token header string true "token"
// @Param data body models.{{.ModelName}}DeleteInputs  true "models.{{.ModelName}}DeleteInputs"
// @Success 200 {object} e.Message
// @Failure 400 {object} e.Message
// @Failure 500 {object} e.Message
// @Router /api/v1/{{.ResourceName}}s-batch [delete]
func {{.ModelName}}BatchDelete(c *gin.Context) {
    var mdlInputs models.{{.ModelName}}DeleteInputs
	err := c.ShouldBind(&mdlInputs)
	if handleRequestError(c, err, constants.CodeParamsError) {
		return
	}
	if len(mdlInputs.List) == 0 {
		handleRequestError(c, err, constants.CodeParamsError)
		return
	}
	err = service.New{{.ModelName}}Service().BatchDelete(mdlInputs)
	if handleError(http.StatusInternalServerError, c, err, constants.CodeServerError) {
		return
	}
	jsonSuccess(c)
}