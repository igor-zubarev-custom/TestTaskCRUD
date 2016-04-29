<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>  
    <title>AngularJS $http Example</title>  
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
     <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"/>
     <link href="<c:url value='/static/css/app.css' />" rel="stylesheet"/>
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
                                      <span ng-show="myForm.uname.$error.required">This is a required field</span>
                                      <span ng-show="myForm.uname.$error.minlength">Minimum length required is 3</span>
                                      <span ng-show="myForm.uname.$error.maxlength">Maximum length required is 25</span>
                                      <span ng-show="myForm.uname.$error.pattern">Only characters</span>
                                      <span ng-show="myForm.uname.$invalid">This field is invalid</span>
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
                                      <span ng-show="myForm.uage.$error.required">This is a required field</span>
                                      <span ng-show="myForm.uage.$error.pattern">Only numbers</span>
                                      <span ng-show="myForm.uage.$error.minlength">Minimum length required is 1</span>
                                      <span ng-show="myForm.uage.$error.maxlength">Maximum length required is 3</span>
                                      <span ng-show="myForm.uage.$invalid">This field is invalid </span>
                                  </div>
                              </div>
                          </div>
                      </div>

                      <%--<div class="row">
                          <div class="form-group col-md-12">
                              <label class="col-md-2 control-lable" for="file">Email</label>
                              <div class="col-md-7">
                                  <input type="email" ng-model="ctrl.user.email" name="email" class="email form-control input-sm" placeholder="Enter your Email" required/>
                                  <div class="has-error" ng-show="myForm.$dirty">
                                      <span ng-show="myForm.email.$error.required">This is a required field</span>
                                      <span ng-show="myForm.email.$invalid">This field is invalid </span>
                                  </div>
                              </div>
                          </div>
                      </div>--%>

                      <h4>Radio &amp; Uncheckable Radio</h4>
                      <pre>{{ctrl.user.admin || false}}</pre>
                      <div class="btn-group">
                          <label class="btn btn-primary">
                              <input type="radio" name="user" data-ng-model="ctrl.user.admin" value="false"> USER
                          </label>
                          <label class="btn btn-primary">
                              <input type="radio" name="admin" data-ng-model="ctrl.user.admin" value="true"> ADMIN
                          </label>
                      </div>

                      <div class="row">
                          <div class="form-actions floatRight">
                              <input type="submit"  value="{{!ctrl.user.id ? 'Add' : 'Update'}}" class="btn btn-primary btn-sm" ng-disabled="myForm.$invalid">
                              <button type="button" ng-click="ctrl.reset()" class="btn btn-warning btn-sm" ng-disabled="myForm.$pristine">Reset Form</button>
                          </div>
                      </div>
                  </form>
              </div>
          </div>
          <div class="panel panel-default">
                <!-- Default panel contents -->
              <div class="panel-heading"><span class="lead">List of Users </span></div>
              <div class="tablecontainer">
                  <table class="table table-hover">
                      <thead>
                          <tr>
                              <th>ID.</th>
                              <th>Name</th>
                              <th>Age</th>
                              <th>Status</th>
                              <th>Create Date</th>
                              <th width="20%"></th>
                          </tr>
                      </thead>
                      <tbody>
                          <tr ng-repeat="u in ctrl.users">
                              <td><span ng-bind="u.id"></span></td>
                              <td><span ng-bind="u.name"></span></td>
                              <td><span ng-bind="u.age"></span></td>
                              <td><span ng-bind="u.admin ? 'ADMIN' : 'USER'"></span></td>
                              <td><span ng-bind="u.createdDate | date:'yyyy-MM-dd hh:mm:ss'"></span></td>
                              <td>
                              <button type="button" ng-click="ctrl.edit(u.id)" class="btn btn-success custom-width">Edit</button>  <button type="button" ng-click="ctrl.remove(u.id)" class="btn btn-danger custom-width">Remove</button>
                              </td>
                          </tr>
                      </tbody>
                  </table>
              </div>
          </div>
      </div>
      
      <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.4/angular.js"></script>
      <script src="<c:url value='/static/js/app.js' />"></script>
      <script src="<c:url value='/static/js/service/user_service.js' />"></script>
      <script src="<c:url value='/static/js/controller/user_controller.js' />"></script>
  </body>
</html>