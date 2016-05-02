'use strict';

App.controller('UserController', ['$scope', 'UserService', function($scope, UserService) {
          var self = this;
          self.user={id:null,name:'',age:null,admin:false,createdDate:0};
          self.users=[];

          self.sortType     = 'name';  //Сортировка по умолчанию
          self.sortReverse  = false;
          self.searchUser   = '';

          self.fetchAllUsers = function(){
              UserService.fetchAllUsers()
                  .then(
      					       function(d) {
      						        self.users = d;
      					       },
            					function(errResponse){
            						console.error('Error while fetching Users');
            					}
      			       );
          };

          self.generateAllUsers = function(){
              UserService.generateAllUsers()
                  .then(
      					       function(d) {
      						        self.users = d;
      					       },
            					function(errResponse){
            						console.error('Error while generate Users');
            					}
      			       );
          };
           
          self.createUser = function(user){
              user.createdDate = new Date();
              UserService.createUser(user)
		              .then(
                      self.fetchAllUsers, 
				              function(errResponse){
					               console.error('Error while creating User.');
				              }	
                  );
          };

         self.updateUser = function(user, id){
              user.createdDate = new Date();
              UserService.updateUser(user, id)
		              .then(
				              self.fetchAllUsers, 
				              function(errResponse){
					               console.error('Error while updating User.');
				              }	
                  );
          };

         self.deleteUser = function(id){
              UserService.deleteUser(id)
		              .then(
				              self.fetchAllUsers, 
				              function(errResponse){
					               console.error('Error while deleting User.');
				              }	
                  );
          };

          self.fetchAllUsers();

          self.submit = function() {
              if(self.user.id==null){
                  console.log('Saving New User', self.user);    
                  self.createUser(self.user);
              }else{
                  self.updateUser(self.user, self.user.id);
                  console.log('User updated with id ', self.user.id);
              }
              self.reset();
          };
              
          self.edit = function(id){
              console.log('id to be edited', id);
              for(var i = 0; i < self.users.length; i++){
                  if(self.users[i].id == id) {
                     self.user = angular.copy(self.users[i]);
                     break;
                  }
              }
          };
              
          self.remove = function(id){
              console.log('id to be deleted', id);
              if(self.user.id === id) {
                 self.reset();
              }
              self.deleteUser(id);
          };

          //Сброс формы
          self.reset = function(){
              self.user={id:null,name:'',age:null,admin:false,createdDate:0};
              $scope.myForm.$setPristine();
          };

      }]);
