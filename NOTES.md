# NOTES

## [Tutorial - Smart Contract](https://docs.covalentx.com/article/89-tutorial)

```shell
$ npm i -g @worldsibu/convector-cli
$ npm i -g @worldsibu/hurley

# create a base project
$ conv new attributesDb -c person

# install dependencies
$ cd attributesDb
$ npm i

# add a new chaincode for managing the Network Participants (organizations) 
$ conv generate chaincode participant

$ npx lerna add participant-cc --scope person-cc  --include-filtered-dependencies
$ npx lerna bootstrap

# restart env
# $ ./restartEnv.sh
# npm WARN notsup Unsupported engine for fabric-shim-crypto@1.4.5: wanted: {"node":"^8.9.0","npm":"^5.5.1"} (current: {"node":"8.16.1","npm":"6.14.0"})

# $ node -v
# v9.11.2

# $ npm -v
# 5.6.0

# Install your development blockchain network
$ npm run env:restart
# Install the smart contract with a version 1
$ npm run cc:start -- person

# Optional - Upgrade if you applied changes to the code - change the 1.1 for the version you'd like to install, it has to be incremental from the previous version
$ npm run cc:upgrade -- person 1.1

CHAINCODE_NAME=person

$ hurl invoke person participant_register gov "Big Government" -u admin
$ hurl invoke person participant_register mit "MIT" -u user1
$ hurl invoke person person_create "{\"id\":\"1-100-100\", \"name\": \"Walter Montes\"}" -u admin

$ hurl invoke person participant_get gov
$ hurl invoke person participant_get mit
$ hurl invoke person person_get 1-100-100
# this must fail with good error validation { Error: transaction returned with failure: {"name":"Error","status":500,"message":"No person exists with that ID pov"}
$ hurl invoke person person_get pov
# this must fail with good error validation { Error: transaction returned with failure: {"name":"Error","status":500,"message":"No person exists with that ID gov"}
# BUT it response with
$ hurl invoke person person_get gov
[hurley] - gov
[hurley] - Sending transaction as user1 in org org1...
[hurley] - Transaction sent! VALID  SUCCESS 74952af5b0f6312bbefa8a1babb39957eab239938ab0cfc37b7c7335443f3e29
[hurley] - Result: {"_id":"gov","_name":"Big Government","_type":"io.worldsibu.examples.participant"}
Cleaning up event hubs
# same with mit
$ hurl invoke person person_get mit
[hurley] - mit
[hurley] - Sending transaction as user1 in org org1...
[hurley] - Transaction sent! VALID  SUCCESS d4cc2c5a2706282dc96136b2796873eea630ab8b49ce857eb8ffbfc0cfdc56e2
[hurley] - Result: {"_id":"mit","_name":"MIT","_type":"io.worldsibu.examples.participant"}
Cleaning up event hubs
# now with participant it returns person john
$ hurl invoke person participant_get 1-100-100
[hurley] - 1-100-100
[hurley] - Sending transaction as user1 in org org1...
[hurley] - Transaction sent! VALID  SUCCESS c99e556b2afc8572eb64a9523d84f420fe20aaa9335dd9b907526760eadfa209
[hurley] - Result: {"_id":"1-100-100","_name":"Walter Montes","_type":"io.worldsibu.person"}
Cleaning up event hubs
```
