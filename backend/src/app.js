import express from 'express';
import dotenv from 'dotenv';

import './database';
import contactRoutes from './routes/contact_routes';

dotenv.config();

class App {
  constructor() {
    this.app = express();
    this.middlewares();
    this.routes();
  }

  middlewares() {
    this.app.use(express.urlencoded({ extended: true }));
    this.app.use(express.json());
  }

  routes() {
    this.app.use('/contact/', contactRoutes);
  }
}

export default new App().app;
