import express from 'express';
import * as advisorController from './advisor.controller.js';
const Router = express.Router();
Router.post('/analyze', advisorController.analyzeFashion);
export const advisorRoute = Router;
//# sourceMappingURL=advisor.route.js.map