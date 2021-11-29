import Sequelize, { Model } from 'sequelize';

export default class Contact extends Model {
  static init(sequelize) {
    super.init({
      name: {
        type: Sequelize.STRING(50),
        defaultValue: '',
        validate: {
          len: {
            args: [1, 50],
            msg: 'Invalid Name',
          },
        },
      },
      email: {
        type: Sequelize.STRING(50),
        defaultValue: '',
        validate: {
          isEmail: {
            msg: 'Invalid Email',
          },
        },
      },
      tel: {
        type: Sequelize.STRING(50),
        validate: {
          len: {
            args: [8, 50],
            msg: 'Invalid Tel',
          },
        },
      },
    }, {
      sequelize,
    });
    return this;
  }
}
