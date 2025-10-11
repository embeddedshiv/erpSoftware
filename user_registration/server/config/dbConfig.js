import { connect } from "mongoose";
import dotenv from "dotenv";

const dbConnect = async() => {
  try {
    const mongoDbConnection = await connect(process.env.CONNECTION_STRING);
    console.log(`Database connection success ${mongoDbConnection.connection.host}`);
  }
  catch (error) {
    console.log(`Database connection failed ${error}`);
    process.exit(1);
  }
};

export default dbConnect;