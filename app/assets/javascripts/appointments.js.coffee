# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@app = angular.module("DoctorPush", ["ngResource",'ui.calendar','ui.bootstrap'])
$(document).on('ready page:load', ->
	angular.bootstrap(document, ['DoctorPush'])
);

app.config(["$httpProvider", (provider) ->
	provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]);

app.factory "Appointment", ($resource) ->
	$resource("/admin/appointments/:id", {id: "@id"}, {update: {method: "PUT"}})

@AppointmentCtrl = ($scope, $log, Appointment) ->
    $scope.appointments = [Appointment.query()]

    $scope.alertOnDrop = (event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view) ->
        $scope.$apply -> console.log('Event Droped to make dayDelta ' + dayDelta)
        console.dir(event)
        Appointment.update(event)

    $scope.alertOnResize = (event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view ) ->
        $scope.$apply -> console.log('Event Droped to make dayDelta ' + dayDelta)
        Appointment.update(event)

    $scope.uiConfig = {
      calendar:{
        height: 450,
        editable: true,
        header:{
          left: 'month basicWeek basicDay agendaWeek agendaDay',
          center: 'title',
          right: 'today prev,next'
        },
        dayClick: $scope.alertEventOnClick,
        eventDrop: $scope.alertOnDrop,
        eventResize: $scope.alertOnResize
      }
    }

	# $scope.appointments = [[
 #        {
 #            title: 'Event1',
 #            start: '2013-10-10'
 #        },
 #        {
 #            title: 'Event2',
 #            start: '2013-10-10'
 #        }
 #    ]]

# @AppointmentCtrl = ($scope, Event, Location, $modal, $log) ->
# 	if $('.edit_event_form').data().eventForm == 0
# 		console.log('new post');
# 		$scope.event = {
# 			locations: Location.query( -> 
# 				$scope.event.location = $scope.event.locations[0]
# 			)
# 		}
# 	else
# 		$scope.event = {
# 	  		name: $('#event_name').val()
# 	  		id: $('.edit_event_form').data().eventForm
# 	  		details: $('#event_details').val()
# 	  		location_id: $('#event_location_id').val()
# 	  		location: Location.get(id: $('#event_location_id').val())
# 	  		locations: Location.query()
# 		}
# 		console.log('old post: '+$scope.event.id)

# 	$scope.selectLocation = (location) ->
# 		$scope.event.location = location

# 	$scope.openNewLocation = ->
# 		modalInstance = $modal.open(
# 			{
# 			 	templateUrl: '/locations/new.modal'
# 			 	controller: ModalInstanceCtrl
# 			 	resolve: {
# 			 		locations: ->
# 			 			return $scope.event.locations
# 			 	}
# 			}
# 		)
# 		modalInstance.result.then(
# 			(newLocation) ->
# 				alert(JSON.stringify(newLocation))
# 				$log.info('Modal closed at: ' + new Date())
# 				$scope.event.locations.push newLocation
# 				$scope.event.location = newLocation
# 			, ->
# 				$log.info('Modal dismissed at: ' + new Date())
# 			)


# @LocationsCtrl = ($scope, Location) ->
# 	$scope.locations = Location.query(->
# 		$scope.activeLocation = $scope.locations[0]
# 		#$scope.activeLocation = $filter('getById')($scope.locations, fish_id);
# 	)



# @ModalInstanceCtrl = ($scope, $modalInstance, locations, Location) ->
# 	#$scope.event.locations = locations
# 	#$scope.selected = {
# 	#	item: $scope.event.locations[0]
# 	#}
# 	$scope.newLocation = {}

# 	#$scope.cancel = ->
# 	#	$modalInstance.dismiss('cancel')

# 	$scope.addLocation = ->
# 		location = Location.save($scope.newLocation)
# 		$modalInstance.close($scope.newLocation)