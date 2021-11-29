import Contact from '../models/Contact';

class ContactController {
  async store(req, res) {
    try {
      await Contact.create(req.body);

      return res.json({ 'message': 'Contact has been Created' });
    } catch (err) {
      return res.status(400).json({ errors: err.errors.map((e) => e.message) });
    }
  }

  async index(req, res) {
    try {
      const contacts = await Contact.findAll({
        attributes: ['id', 'name', 'email', 'tel'],
      });
      return res.json(contacts);
    } catch (err) {
      return res.status(400).json({ errors: err.errors.map((e) => e.message) });
    }
  }

  async update(req, res) {
    try {
      const { id } = req.body;
      if (!id) {
        return res.status(400).json({ errors: ['ID not Found'] });
      }

      const contact = await Contact.findByPk(id);
      if (!contact) {
        return res.status(400).json({ errors: ['Contact not Found'] });
      }

      await contact.update(req.body);
      return res.json({ 'message': 'Contact has been Updated' });
    } catch (err) {
      return res.status(400).json({ errors: err.errors.map((e) => e.message) });
    }
  }

  async delete(req, res) {
    try {
      const { id } = req.body;
      if (!id) {
        return res.status(400).json({ errors: ['ID not Found'] });
      }

      const contact = await Contact.findByPk(id);
      if (!contact) {
        return res.status(400).json({ errors: ['Contact not Found'] });
      }

      await contact.destroy();
      return res.json({ 'message': 'Contact has been Deleted' });
    } catch (err) {
      return res.status(400).json({ errors: err.errors.map((e) => e.message) });
    }
  }
}

export default new ContactController();
