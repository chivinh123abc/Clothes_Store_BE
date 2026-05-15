import dotenv from 'dotenv';
dotenv.config({ path: '../Clothes_Store_BE/.env' });
import { pool } from './src/configs/database.js';

async function updateOrderEnum() {
  try {
    console.log('--- UPDATING ORDER_STATUS ENUM ---');

    // Add new values to the enum
    // Note: PostgreSQL doesn't allow ALTER TYPE ... ADD VALUE inside a transaction block in older versions,
    // but here we are running individual commands.
    
    const newStatuses = ['paid', 'shipping', 'completed', 'cancelled'];
    
    for (const status of newStatuses) {
      try {
        await pool.query(`ALTER TYPE order_status ADD VALUE '${status}'`);
        console.log(`✅ Added '${status}' to order_status enum.`);
      } catch (e) {
        if (e.code === '42710') {
          console.log(`ℹ️ '${status}' already exists in order_status enum.`);
        } else {
          console.error(`❌ Error adding '${status}':`, e.message);
        }
      }
    }

    console.log('--- ENUM UPDATE COMPLETE ---');
  } catch (error) {
    console.error('❌ General Error:', error);
  } finally {
    await pool.end();
  }
}

updateOrderEnum();
