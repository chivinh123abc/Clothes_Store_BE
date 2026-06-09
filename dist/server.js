var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
/* eslint-disable no-console */
import cookieParser from 'cookie-parser';
import cors from 'cors';
import { asyncExitHook } from 'exit-hook';
import express from 'express';
import { pool } from './configs/database.js';
import { RedisProvider } from './providers/RedisProvider.js';
import { env } from './configs/environment.js';
import { setupSwagger } from './configs/swagger.js';
import { errorHandlingMiddleware } from './middlewares/errorHandlingMiddleware.js';
import { APIs } from './routes/index.js';
const START_SERVER = () => __awaiter(void 0, void 0, void 0, function* () {
    const app = express();
    //phan ben trong {} dung de chi dinh BE origin va FE tu domain khac, nen la phai dung
    app.use(cors({
        origin: env.CLIENT_URL,
        credentials: true
    }));
    app.use(express.json({ limit: '10mb' }));
    app.use(cookieParser());
    // dung swagger UI
    setupSwagger(app);
    //check alive
    app.get('/health', (_req, res) => {
        res.status(200).json({ status: 'ok' });
    });
    app.use('/api/v1', APIs);
    //Xu li loi
    app.use(errorHandlingMiddleware);
    const PORT = Number(env.PORT) || 3000;
    const HOST = env.HOST || '0.0.0.0';
    app.listen(PORT, HOST, () => {
        console.log(`[SERVER] Server running at http://${HOST}:${PORT}/`);
        if (env.BUILD_MODE === 'dev') {
            console.log(`Health check at http://localhost:${PORT}/health`);
            console.log(`Swagger docs at http://localhost:${PORT}/api-docs`);
        }
    });
    // Ket noi Redis
    yield RedisProvider.connect();
    // EXIT HOOK
    asyncExitHook(() => __awaiter(void 0, void 0, void 0, function* () {
        console.log('[SERVER]: Server is shutting down');
        pool.end();
        console.log('[DATABASE]: Database is shutting down');
        yield RedisProvider.disconnect();
    }), {
        wait: 300
    });
});
export const Server = {
    START_SERVER
};
//# sourceMappingURL=server.js.map