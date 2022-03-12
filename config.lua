Config = {}

Config.taxiDispatch = true -- Set to true if you would like to send a dispatch message to the taxi company. 
--This needs to be setup in client.lua line 39 setup for https://forum.cfx.re/t/esx-qbcore-dispatch-multiple-jobs-onesync-and-infinity-paid/4768990 by default

Config.bikeLocations = {
   --Apartment Locations
    vector3(293.13, -1075.57, 29.41), -- Fantastic plaza
    vector3(270.39, -638.87, 42.02), -- Integrity way apartments
    vector3(-667.03, -1103.4, 14.67), -- South Rockford apartments
    vector3(-1289.2, -427.23, 34.77), --Morningwood blvd apartments
    vector3(-616.95, 37.94, 43.6), --Tinsel towers
    --Spawn locations
    vector3(328.49, -201.69, 54.09), -- Motels
    vector3(78.39, 6425.63, 31.63), --Paleto bay
    vector3(195.17, -933.77, 30.69), -- Legion sqaure
    vector3(1534.55, 3777.17, 34.5), -- Sandy shores
    -- Hospitals
    vector3(1843.17, 3670.85, 33.68), -- Sandy shores
    vector3(299.8, -579.72, 43.26), -- Pilbox
    vector3(-238.21, 6324.51, 32.43), -- Paleto Bay
    -- Prison
    vector3(1853.08, 2590.1, 45.67)
}

Config.bikeModel = 'bmx'

Config.cooldownTime = 900000 --15 minutes

