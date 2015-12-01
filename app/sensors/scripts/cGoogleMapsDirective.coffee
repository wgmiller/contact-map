angular
  .module('sensors')
  .directive 'cGoogleMaps', ($window, supersonic) ->
    restrict: "E"
    template: """<div class="g-maps-container"></div>"""
    replace: true
    scope:
      position: "="
    link: ($scope, element, attr) ->

      # Create map element
      el = document.createElement "div"
      element.prepend el

      # Create map object on the map element
      demoMap = new google.maps.Map el,
        zoom: 4
        mapTypeId: google.maps.MapTypeId.ROADMAP
        disableDefaultUI: true
        draggable: true

      # Create map marker
      demoAccuracyCircle = new google.maps.Circle
        map: demoMap
        fillColor: "#00B5FF"
        fillOpacity: 0
        strokeColor: "#00B5FF"
        strokeOpacity: 0.5
        strokeWeight: 2

      # Create map marker
      demoMarker = new google.maps.Marker
        map: demoMap
        #icon: 'http://style3.ravelrycache.com/images/twemoji/1f600.png'
        position: {lat: 35.000, lng: -79.000}

      # Method to find mapped contacts
      findMapped = ->
        options = new ContactFindOptions()
        options.filter = ","
        options.multiple = true
        fields = ["displayName", "name", "note"]
        navigator.contacts.find fields, onSuccess, onError, options

      # Method for found contacts
      onSuccess = (contacts) ->
        #navigator.notification.alert("Note = " + contacts.length)

        i=0
        j=contacts.length
        while i<j
          new google.maps.Marker
            map: demoMap
            position: getNoteCoordinates(contacts[i])
            label: contacts[i].name.formatted
          i++
 
      # Method to handle Errors
      onError = (contactError) ->
        alert 'onError!'
        return

      # Method to find contact's coordinates
      getNoteCoordinates = (contact) ->
        comma = contact.note.indexOf(',')
        lat = contact.note.substring(0, comma)
        lon = contact.note.substring(comma + 2, contact.note.length)
        latlng = new (google.maps.LatLng)(lat, lon)
        latlng

      # Method for updating location
      updateLocation = ->
        newLatLng = new google.maps.LatLng $scope.position.latitude, $scope.position.longitude
        demoMap.setCenter newLatLng
        demoMarker.setPosition newLatLng
        demoAccuracyCircle.setCenter newLatLng
        demoAccuracyCircle.setRadius $scope.position.accuracy
        findMapped()


      # Watch for changes in position
      $scope.$watch "position", ->
        updateLocation()
      , true