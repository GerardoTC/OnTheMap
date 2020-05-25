//
//  Constants.swift
//  On The Map
//
//  Created by Gerardo Tarazona Caceres on 5/9/20.
//  Copyright © 2020 gerardo. All rights reserved.
//

import Foundation
import UIKit

struct LoginConstants {
    static let emailError = "The email you added is not valid"
    static let emptyPassword = "You Must provide a password"
}


struct ClientConstants {
    struct httpMethod {
        static let post = "POST"
        static let get = "GET"
        static let delete = "DELETE"
        static let put = "PUT"
    }
    struct requestContent {
        static let applicationJson = "application/json"
        static let accept = "Accept"
        static let contentType = "Content-Type"
        static let xsrf = "XSRF-TOKEN"
        static let xxsrf = "X-XSRF-TOKEN"
    }
}

struct ViewsConstants {
    struct storyBoards {
        static let main = "Main"
        static let setupPin = "SetupPin"
    }
    struct vcs {
        static let login = "LoginViewController"
        static let rootnav = "RootNavController"
        static let tabsvc = "TabsViewController"
        static let locationlist = "LocationListViewController"
        static let mapView = "MapViewController"
        static let findLoc = "FindLocationViewController"
        static let findLocNav = "FindLocationNav"
        static let findMapLoc = "FindMapLocationViewController"
    }
}

struct ImagesConstants {
    static let mapViewSelected = UIImage(named: "mapview_selected_icon")
    static let mapViewDeselected = UIImage(named: "mapview_deselected_icon")
    static let listViewSelected = UIImage(named: "listview-selected_icon")
    static let listViewDeselected = UIImage(named: "listview-deselected_icon")
    static let refreshImage = UIImage(named: "refresh_icon")
    static let addpinImage = UIImage(named: "add_pin_icon")
    static let pinImage = UIImage(named: "pin_icon")
}

struct FindLocationConstants {
    static let title = "Add Location"
    static let locationTextEmpty = "Location text is empty please enter a valid text"
    static let linkTextEmpty = "Link text is empty please enter a valid text"
    static let wrongLink = "The Link provided can't be handled please try with a different one"
    static let wrongLocation = "The location could'nt be founded please add more information to the location field"
    
}

struct LocationListConstants {
    static let identifier = "LocationViewCell"
    static let invalidUrl = "Invalid Url found, sorry but "
    static let pinText = "the pin"
    static let invalidLink = " has an invalid link"
    static let limit = 100
}

struct MapViewConstants {
    static let annotationId = "IdentifierAnnotation"
    static let invalidUrl = "Invalid Url found, sorry but "
    static let pinText = "the pin"
    static let invalidLink = " has an invalid link"
    static let limit = 100
}

struct TabsViewConstants {
    static let title = "On The Map"
}

struct ExtensionConstants {
    static let cancel = "Cancel"
    static let logout = "LOGOUT"
    static let oops = "Oops..."
    static let ok = "Ok"
}

struct DictionaryIds {
    static let updatedAt = "updatedAt"
    static let objectId = "objectId"
    static let firstName = "first_name"
    static let lastName = "last_name"
}

struct DataErrorConstants {
    static let noData = "No data returned verify your connection"
    static let unknown = "Something went wrong pelase try again"
}
