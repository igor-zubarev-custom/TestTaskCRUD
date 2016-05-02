<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>  
    <title>TestTaskCRUD</title>
    <style>
      .name.ng-valid {
          background-color: lightgreen;
      }
      .name.ng-dirty.ng-invalid-required {
          background-color: red;
      }
      .name.ng-dirty.ng-invalid-minlength {
          background-color: yellow;
      }

      .age.ng-valid {
          background-color: lightgreen;
      }
      .age.ng-dirty.ng-invalid-required {
          background-color: red;
      }
      .age.ng-dirty.ng-invalid-email {
          background-color: yellow;
      }
    </style>
     <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"/>
     <link href="<c:url value='/static/css/bootstrap.css' />" rel="stylesheet"/>
     <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">

  </head>
  <body ng-app="myApp" class="ng-cloak">
      <div class="generic-container" ng-controller="UserController as ctrl">
          <div class="panel panel-default">
              <div class="panel-heading"><span class="lead">User Registration Form </span></div>
              <div class="formcontainer">
                  <form ng-submit="ctrl.submit()" name="myForm" class="form-horizontal">
                      <input type="hidden" ng-model="ctrl.user.id" />
                      <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="uname">Name</label>
                              <div class="col-md-7">
                                  <input type="text" ng-model="ctrl.user.name" name="uname" class="name form-control input-sm" placeholder="Enter user name" required ng-minlength="3" ng-maxlength="25" ng-pattern="'\\D+'"/>
                                  <div class="has-error" ng-show="myForm.$dirty">
                                      <span ng-show="myForm.uname.$error.required">This is a required field </span>
                                      <span ng-show="myForm.uname.$error.minlength">Minimum length required is 3 </span>
                                      <span ng-show="myForm.uname.$error.maxlength">Maximum length required is 25 </span>
                                      <span ng-show="myForm.uname.$error.pattern">Only characters </span>
                                      <span ng-show="myForm.uname.$invalid">This field is invalid </span>
                                  </div>
                              </div>
                          </div>
                      </div>
                        
                      
                      <div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="uage">Age</label>
                              <div class="col-md-7">
                                  <input type="text" ng-model="ctrl.user.age" name="uage" class="age form-control input-sm" placeholder="Enter user age." required ng-minlength="1" ng-maxlength="3" ng-pattern="'\\d+'"/>
                                  <div class="has-error" ng-show="myForm.$dirty">
                                      <span ng-show="myForm.uage.$error.required">This is a required field </span>
                                      <span ng-show="myForm.uage.$error.pattern">Only numbers </span>
                                      <span ng-show="myForm.uage.$error.minlength">Minimum length required is 1 </span>
                                      <span ng-show="myForm.uage.$error.maxlength">Maximum length required is 3 </span>
                                      <span ng-show="myForm.uage.$invalid">This field is invalid </span>
                                  </div>
                              </div>
                          </div>
                      </div>

                      <div class="row">
                      <div class="form-group col-md-12">
                          <label class="col-md-2 control-lable">Role (default USER)</label>
                          <div class="col-md-7">
                          <label class="btn btn-primary btn-sm">
                              <input type="radio" name="user" ng-model="ctrl.user.admin" value="false"> USER
                          </label>
                          <label class="btn btn-primary btn-sm">
                              <input type="radio" name="admin" ng-model="ctrl.user.admin" value="true"> ADMIN
                          </label>
                          </div>
                      </div>
                      </div>

                      <div class="row">
                          <div class="form-actions floatRight">
                              <input type="submit"  value="{{!ctrl.user.id ? 'Add' : 'Update'}}" class="btn btn-primary btn-sm" ng-disabled="myForm.$invalid">
                              <button type="button" ng-click="ctrl.reset()" class="btn btn-warning btn-sm" ng-disabled="myForm.$pristine">Reset Form</button>
                              <button type="button" ng-click="ctrl.generateAllUsers()" class="btn btn-primary btn-sm">Generate Users</button>
                          </div>
                      </div>
                  </form>
              </div>
          </div>

          <%-------------------------------------------------------------------------------------------------------------%>
          <div class="panel-heading">
              <span class="lead">List of Users </span>
          </div>
          <div class="tablecontainer">
              <form>
                  <div class="form-group">
                      <div class="input-group">
                          <div class="input-group-addon"><i class="fa fa-search"></i></div>
                          <input type="text" class="form-control" placeholder="Search users for name or age" ng-model="searchUser">
                      </div>
                  </div>
              </form>

              <table class="table table-bordered table-striped">
                  <thead>
                  <tr>
                      <td>
                          <a href="#" ng-click="sortType = 'id'; sortReverse = !sortReverse">
                              ID
                              <span ng-show="sortType == 'id' && !sortReverse" class="fa fa-caret-down"></span>
                              <span ng-show="sortType == 'id' && sortReverse" class="fa fa-caret-up"></span>
                          </a>
                      </td>
                      <td>
                          <a href="#" ng-click="sortType = 'name'; sortReverse = !sortReverse">
                              Name
                              <span ng-show="sortType == 'name' && !sortReverse" class="fa fa-caret-down"></span>
                              <span ng-show="sortType == 'name' && sortReverse" class="fa fa-caret-up"></span>
                          </a>
                      </td>
                      <td>
                          <a href="#" ng-click="sortType = 'age'; sortReverse = !sortReverse">
                              Age
                              <span ng-show="sortType == 'age' && !sortReverse" class="fa fa-caret-down"></span>
                              <span ng-show="sortType == 'age' && sortReverse" class="fa fa-caret-up"></span>
                          </a>
                      </td>
                      <td>
                          <a href="#" ng-click="sortType = 'admin'; sortReverse = !sortReverse">
                              Status
                              <span ng-show="sortType == 'admin' && !sortReverse" class="fa fa-caret-down"></span>
                              <span ng-show="sortType == 'admin' && sortReverse" class="fa fa-caret-up"></span>
                          </a>
                      </td>
                      <td>
                          <a href="#" ng-click="sortType = 'createdDate'; sortReverse = !sortReverse">
                              Create Date
                              <span ng-show="sortType == 'createdDate' && !sortReverse" class="fa fa-caret-down"></span>
                              <span ng-show="sortType == 'createdDate' && sortReverse" class="fa fa-caret-up"></span>
                          </a>
                      </td>
                  </tr>
                  </thead>

                  <tbody>
                      <tr dir-paginate="u in ctrl.users | orderBy:sortType:sortReverse | filter:searchUser | itemsPerPage:10">
                          <td>{{ u.id }}</td>
                          <td>{{ u.name }}</td>
                          <td>{{ u.age }}</td>
                          <td>{{ u.admin ? 'ADMIN' : 'USER' }}</td>
                          <td>{{ u.createdDate | date:'yyyy-MM-dd HH:mm:ss' }}</td>
                          <td>
                              <button type="button" ng-click="ctrl.edit(u.id)" class="btn btn-success custom-width">Edit</button>  <button type="button" ng-click="ctrl.remove(u.id)" class="btn btn-danger custom-width">Remove</button>
                          </td>
                      </tr>
                      <tr>
                          <dir-pagination-controls
                                  max-size="10"
                                  direction-links="true"
                                  boundary-links="true" >
                          </dir-pagination-controls>
                      </tr>
                  </tbody>
              </table>
          </div>
          <%-------------------------------------------------------------------------------------------------------%>
      </div>
      
      <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.4/angular.js"></script>
      <script src="<c:url value='/static/js/app.js' />"></script>
      <script src="<c:url value='/static/js/service/user_service.js' />"></script>
      <script src="<c:url value='/static/js/controller/user_controller.js' />"></script>
      <script src="<c:url value='/static/js/controller/dirPagination.js' />"></script>
  </body>
</html>