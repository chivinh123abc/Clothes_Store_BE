import express from 'express'
import { cartItemRoute } from '../modules/cart_items/cart_item.route.js'
import { cartRoute } from '../modules/carts/cart.route.js'
import { categoryRoute } from '../modules/categories/category.route.js'
import { orderItemRoute } from '../modules/order_items/order_item.route.js'
import { orderRoute } from '../modules/orders/order.route.js'
import { productConfigurationRoute } from '../modules/product_configurations/product_configurations.route.js'
import { productItemRoute } from '../modules/product_items/product_item.route.js'
import { productRoute } from '../modules/products/product.route.js'
import { userRoute } from '../modules/users/user.route.js'
import { variationOptionRoute } from '../modules/variation_options/variation_option.route.js'
import { variationRoute } from '../modules/variations/variation.route.js'

const Router = express.Router()

Router.use('/user', userRoute)

Router.use('/category', categoryRoute)

Router.use('/product', productRoute)

Router.use('/product_item', productItemRoute)

Router.use('/variation', variationRoute)

Router.use('/variation_option', variationOptionRoute)

Router.use('/product_configuration', productConfigurationRoute)

Router.use('/order', orderRoute)

Router.use('/order_item', orderItemRoute)

Router.use('/cart', cartRoute)

Router.use('/cart_item', cartItemRoute)

export const APIs = Router
