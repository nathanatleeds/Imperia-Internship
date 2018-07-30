import axios from "axios";

const instance = axios.create({
  baseURL: "https://react-my-burger-189f3.firebaseio.com/"
});

export default instance;
