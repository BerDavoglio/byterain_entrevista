import { Router } from 'express';
import contactController from '../controllers/contact_controller';

const router = new Router();

router.post('/', contactController.store); // (C)reate Contact
router.get('/', contactController.index); // (R)ead all Contacts
router.put('/', contactController.update); // (U)pdate Contact
router.delete('/', contactController.delete); // (D)elete Contact

export default router;
