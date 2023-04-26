# Technical Documentation
``Version 1.0``

## Overview

Information on program structure and development


## Development

- MVVM
Model, View, ViewModel is used as the acting architech pattern for coding structure.
Distrtibuted to seperate files when functionality and front/back end interaction becomes complex

- Trello
Used to track development tasks.
Flags: Core Features, Optional, Fix, UI, General App Management


## Views

- Main
Display list of Entries
Cells: provide basic information on the route and block. Color highlighting of current dates and incomplete entries.

- Block Creation
Inputs for Block
Error alert on creation with missing input data

- Route Information
Display Block information and Modification of Route data


## Testing

- Functionality Testing
Basic Testing used on certain model and class functionality

- UI Testing
None. Real time testing using simulator


## Core Data

- Block 
- Route
- Block + Route (relation key: id:UUID)
