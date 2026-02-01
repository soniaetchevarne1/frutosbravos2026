import { Product, Order, OrderStatus } from './types';
import clientPromise from './mongodb';

const DB_NAME = 'frutosbravos';

// --- PRODUCTS ---

export async function getProducts(): Promise<Product[]> {
    try {
        const client = await clientPromise;
        const db = client.db(DB_NAME);
        const products = await db.collection<Product>('products').find({}).sort({ order: 1 }).toArray();
        return products;
    } catch (error) {
        console.error('Error obteniendo productos:', error);
        return [];
    }
}

export async function getProduct(slug: string): Promise<Product | undefined> {
    try {
        const client = await clientPromise;
        const db = client.db(DB_NAME);
        const product = await db.collection<Product>('products').findOne({ slug });
        return product || undefined;
    } catch (error) {
        console.error('Error obteniendo producto:', error);
        return undefined;
    }
}

export async function saveProduct(product: Product) {
    try {
        const client = await clientPromise;
        const db = client.db(DB_NAME);

        await db.collection<Product>('products').updateOne(
            { id: product.id },
            { $set: product },
            { upsert: true }
        );

        return product;
    } catch (error) {
        console.error('Error guardando producto:', error);
        throw error;
    }
}

export async function deleteProduct(id: string) {
    try {
        const client = await clientPromise;
        const db = client.db(DB_NAME);
        await db.collection<Product>('products').deleteOne({ id });
    } catch (error) {
        console.error('Error eliminando producto:', error);
        throw error;
    }
}

export async function reorderProducts(products: Product[]) {
    try {
        const client = await clientPromise;
        const db = client.db(DB_NAME);

        // Actualizar el orden de cada producto
        const bulkOps = products.map((product, index) => ({
            updateOne: {
                filter: { id: product.id },
                update: { $set: { ...product, order: index } },
                upsert: true
            }
        }));

        if (bulkOps.length > 0) {
            await db.collection<Product>('products').bulkWrite(bulkOps);
        }
    } catch (error) {
        console.error('Error reordenando productos:', error);
        throw error;
    }
}

// --- ORDERS ---

export async function getOrders(): Promise<Order[]> {
    try {
        const client = await clientPromise;
        const db = client.db(DB_NAME);
        const orders = await db.collection<Order>('orders')
            .find({})
            .sort({ date: -1 })
            .toArray();
        return orders;
    } catch (error) {
        console.error('Error obteniendo órdenes:', error);
        return [];
    }
}

export async function saveOrder(order: Order) {
    try {
        const client = await clientPromise;
        const db = client.db(DB_NAME);

        await db.collection<Order>('orders').insertOne(order);

        console.log('📦 Nuevo pedido guardado en MongoDB:', {
            id: order.id,
            customer: `${order.customer.firstName} ${order.customer.lastName}`,
            total: order.total,
            phone: order.customer.phone
        });

        return order;
    } catch (error) {
        console.error('Error guardando pedido:', error);
        throw error;
    }
}

export async function updateOrderStatus(id: string, status: OrderStatus) {
    try {
        const client = await clientPromise;
        const db = client.db(DB_NAME);

        await db.collection<Order>('orders').updateOne(
            { id },
            { $set: { status } }
        );
    } catch (error) {
        console.error('Error actualizando estado de orden:', error);
        throw error;
    }
}
