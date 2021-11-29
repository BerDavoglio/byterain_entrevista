import Sequelize from 'sequelize';
import databaseConfig from '../config/database';

import contact from '../models/Contact';

const models = [contact];
const connection = new Sequelize(databaseConfig);

models.forEach((model) => model.init(connection));
