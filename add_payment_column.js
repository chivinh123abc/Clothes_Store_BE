import dotenv from 'dotenv';
dotenv.config({ path: '../Clothes_Store_BE/.env' });
import { pool } from './src/configs/database.js';

async function addPaymentMethodColumn() {
  try {
    console.log('--- ADDING PAYMENT_METHOD COLUMN TO ORDERS TABLE ---');

    await pool.query(`
      ALTER TABLE orders 
      ADD COLUMN IF NOT EXISTS payment_method VARCHAR(50) DEFAULT 'cod'
    `);

    console.log('✅ Successfully added payment_method column.');
    console.log('--- DB UPDATE COMPLETE ---');
  } catch (error) {
    console.error('❌ Error updating database:', error.message);
  } finally {
    await pool.end();
  }
}

addPaymentMethodColumn();
