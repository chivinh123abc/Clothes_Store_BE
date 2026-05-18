import dotenv from 'dotenv';
import path from 'path';
import { fileURLToPath } from 'url';
import fs from 'fs';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Explicitly load the backend .env file first
dotenv.config({ path: path.join(__dirname, '.env') });

async function runSeed() {
  try {
    console.log('--- DB SEED STARTED ---');
    
    // Dynamically import database pool after dotenv has successfully loaded the variables
    const { pool } = await import('./src/configs/database.js');
    
    const sqlPath = path.join(__dirname, 'Seed_Data.sql');
    console.log(`Reading SQL file from: ${sqlPath}`);
    const sql = fs.readFileSync(sqlPath, 'utf8');

    console.log('Executing SQL statements...');
    await pool.query(sql);
    console.log('✅ DB seeded successfully with new product items!');
    await pool.end();
  } catch (error) {
    console.error('❌ Error seeding DB:', error);
  } finally {
    console.log('--- DB SEED FINISHED ---');
  }
}

runSeed();
