# Read more about app structure at http://docs.appgyver.com

module.exports =

  # See styling options for tabs and other native components in app/common/native-styles/ios.css or app/common/native-styles/android.css
  tabs: [
    {
      title: "Home"
      id: "home"
      location: "sensors#geolocation" # Supersonic module#view type navigation
    }
    {
      title: "Contacts"
      id: "contacts"
      location: "sensors#find"
    }
  ]

  # rootView:
  #   location: "sensors#find"

  preloads: [
    {
      id: "learn-more"
      location: "example#learn-more"
    }
    {
      id: "sensors-find"
      location: "sensors#find"
    }
    # Sensors
    {
      id: "sensors-geolocation"
      location: "sensors#geolocation"
    }
  ]
  
  # drawers:
  #   left:
  #     id: "leftDrawer"
  #     location: "example#drawer"
  #     showOnAppLoad: false
  #   options:
  #     animation: "swingingDoor"
  #
  # initialView:
  #   id: "initialView"
  #   location: "example#initial-view"
