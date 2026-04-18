/* eslint-disable no-console */
import cookieParser from 'cookie-parser'
import cors from 'cors'
import { asyncExitHook } from 'exit-hook'
import express from 'express'
import { pool } from './configs/database.js'
import { env } from './configs/environment.js'
import { setupSwagger } from './configs/swagger.js'
import { errorHandlingMiddleware } from './middlewares/errorHandlingMiddleware.js'
import { APIs } from './routes/index.js'

const START_SERVER = () => {
  const app = express()

  //phan ben trong {} dung de chi dinh BE origin va FE tu domain khac, nen la phai dung
  app.use(cors({
    origin: env.CLIENT_URL,
    credentials: true
  }))
  app.use(express.json())
  app.use(cookieParser())
  // dung swagger UI
  setupSwagger(app)

  //check alive
  app.get('/health', (_req, res) => {
    res.status(200).json({ status: 'ok' })
  })

  app.use('/api/v1', APIs)
  //Xu li loi
  app.use(errorHandlingMiddleware)
  const PORT = Number(env.PORT) || 3000
  const HOST = env.HOST || '0.0.0.0'
  app.listen(PORT, HOST, () => {
    console.log(`[SERVER] Server running at http://${HOST}:${PORT}/`)
    if (env.BUILD_MODE === 'dev') {
      console.log(`Health check at http://localhost:${PORT}/health`)
      console.log(`Swagger docs at http://localhost:${PORT}/api-docs`)
    }
  })
  // EXIT HOOK
  asyncExitHook(async () => {
    console.log('[SERVER]: Server is shutting down')
    pool.end()
    console.log('[DATABASE]: Database is shutting down')
  }, {
    wait: 300
  })
}


export const Server = {
  START_SERVER
}
