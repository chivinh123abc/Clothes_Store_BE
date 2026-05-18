import express from 'express'
import { cartItemRoute } from '../modules/cart_items/cart_item.route.js'
import { cartRoute } from '../modules/carts/cart.route.js'
import { categoryRoute } from '../modules/categories/category.route.js'
import { collectionRoute } from '../modules/collections/collection.route.js'
import { discountRoute } from '../modules/discounts/discount.route.js'
import { orderItemRoute } from '../modules/order_items/order_item.route.js'
import { orderRoute } from '../modules/orders/order.route.js'
import { paymentRoute } from '../modules/payment/payment.route.js'
import { productConfigurationRoute } from '../modules/product_configurations/product_configurations.route.js'
import { productItemRoute } from '../modules/product_items/product_item.route.js'
import { productRoute } from '../modules/products/product.route.js'
import { adminUserRoute } from '../modules/users/admin_user.route.js'
import { userRoute } from '../modules/users/user.route.js'
import { variantOptionRoute } from '../modules/variant_options/variant_option.route.js'
import { variantRoute } from '../modules/variants/variant.route.js'
import { uploadRoute, userUploadRoute } from './upload.route.js'

const Router = express.Router()

Router.use('/user', userRoute)
Router.use('/user/upload', userUploadRoute)
Router.use('/admin/users', adminUserRoute)
Router.use('/admin/upload', uploadRoute)

Router.use('/category', categoryRoute)

Router.use('/product', productRoute)

Router.use('/collection', collectionRoute)

Router.use('/discount', discountRoute)

Router.use('/product_item', productItemRoute)

Router.use('/variant', variantRoute)

Router.use('/variant_option', variantOptionRoute)

Router.use('/product_configuration', productConfigurationRoute)

Router.use('/order', orderRoute)

Router.use('/order_item', orderItemRoute)

Router.use('/cart', cartRoute)

Router.use('/cart_item', cartItemRoute)

Router.use('/payment', paymentRoute)

export const APIs = Router
