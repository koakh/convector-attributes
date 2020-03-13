#!/bin/sh

npm run env:restart
npm run cc:start -- person

hurl invoke person participant_register gov "Big Government" -u admin
hurl invoke person participant_register mit "MIT" -u user1
hurl invoke person person_create "{\"id\":\"1-100-100\", \"name\": \"Walter Montes\"}" -u admin

echo 'this must fail with good error validation { Error: transaction returned with failure: {"name":"Error","status":500,"message":"No person exists with that ID pov"}'
hurl invoke person person_get pov
echo 'this must fail with good error validation { Error: transaction returned with failure: {"name":"Error","status":500,"message":"No person exists with that ID gov"}, BUT it response with Result: {"_id":"gov","_name":"Big Government","_type":"io.worldsibu.examples.participant"}'
hurl invoke person person_get gov

echo 'same with mit Result: {"_id":"mit","_name":"MIT","_type":"io.worldsibu.examples.participant"}'
hurl invoke person person_get mit

echo 'now with participant it returns person john'
hurl invoke person participant_get 1-100-100
