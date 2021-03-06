module.exports = {
  networks: {
    development: {
      from: '',
      privateKey: '',
      consume_user_resource_percent: 30,
      fee_limit: 100000000,
      fullNode: "https://api.trongrid.io:8090",
      solidityNode: "https://api.trongrid.io:8091",
      eventServer: "https://api.trongrid.io",
      network_id: "*" // Match any network id
    }
  }
};
