import Web3 from "web3";

// Connect to the Ethereum node
const web3 = new Web3("https://mainnet.infura.io/v3/YOUR_INFURA_PROJECT_ID");

// Define the address to check balance for
const address = "0x742d35Cc6634C0532925a3b844Bc454e4438f44e"; // Replace with any Ethereum address

// Function to get and print the balance
const getBalance = async (addr: string) => {
  try {
    // Get balance in Wei
    const balanceWei = await web3.eth.getBalance(addr);
    // Convert balance to Ether
    const balanceEth = web3.utils.fromWei(balanceWei, "ether");
    console.log(`Balance of address ${addr}: ${balanceEth} ETH`);
  } catch (error) {
    console.error("Error getting balance:", error);
  }
};

// Call the function
getBalance(address);
