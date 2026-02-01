"use client";

import { useState, useEffect } from 'react';
import styles from '../admin.module.css';
import { Edit, Trash2, Plus, Search } from 'lucide-react';
import { Product } from '@/lib/types';
import { deleteProductAction } from '@/app/actions';
import ProductForm from './ProductForm';

// We can't import `getProducts` directly in Client Component if it uses `fs`.
// Strategy: Make the page a Server Component that passes data to a Client Component "ProductList".
// BUT to keep it simple, I'll fetch data via a classic API route or just reload. 
// Actually, let's use the Pattern: Page (Server) -> ClientList (Client).

export default function AdminProductsClient({ initialProducts }: { initialProducts: Product[] }) {
    const [products, setProducts] = useState<Product[]>(initialProducts);
    const [searchTerm, setSearchTerm] = useState('');
    const [isFormOpen, setIsFormOpen] = useState(false);
    const [editingProduct, setEditingProduct] = useState<Product | undefined>(undefined);

    // Sync with server state if revalidated? 
    // In Next.js App Router, router.refresh() handles this. 
    // For this simple custom DB, we might need manual refresh or just trust the initialProducts prop updates on revalidatePath.
    useEffect(() => {
        setProducts(initialProducts);
    }, [initialProducts]);

    // View mode removed at user request

    const filteredProducts = products.filter(p =>
        p.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        p.category.toLowerCase().includes(searchTerm.toLowerCase())
    );

    const handleDelete = async (id: string) => {
        if (confirm('¿Estás seguro de eliminar este producto?')) {
            await deleteProductAction(id);
        }
    };

    const handleEdit = (product: Product) => {
        setEditingProduct(product);
        setIsFormOpen(true);
    };

    const handleNew = () => {
        setEditingProduct(undefined);
        setIsFormOpen(true);
    };

    return (
        <>
            <div className={styles.header}>
                <div>
                    <h1 className="h2" style={{ color: 'var(--text-main)', marginBottom: '0.5rem' }}>Gestión de Productos</h1>
                    <p className="body-sm">Administra tu catálogo, precios y stock.</p>
                </div>
                <button className="btn btn-primary" onClick={handleNew}>
                    <Plus size={20} /> Nuevo Producto
                </button>
            </div>

            {/* Filters & Toggle */}
            <div style={{
                background: 'white',
                padding: '1rem',
                borderRadius: '8px',
                border: '1px solid var(--border)',
                marginBottom: '1.5rem',
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
                gap: '1rem',
                flexWrap: 'wrap'
            }}>
                <div style={{ position: 'relative', flex: 1, minWidth: '250px' }}>
                    <Search size={20} style={{ position: 'absolute', left: '10px', top: '50%', transform: 'translateY(-50%)', color: 'var(--text-secondary)' }} />
                    <input
                        type="text"
                        placeholder="Buscar por nombre o categoría..."
                        style={{ width: '100%', padding: '0.75rem 0.75rem 0.75rem 2.5rem', border: '1px solid var(--border)', borderRadius: '6px' }}
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                    />
                </div>

            </div>

            {/* Table View - Excel Style */}
            <div className={styles.tableCard}>
                <table className={styles.table}>
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Categoría</th>
                            <th>Precio Minorista</th>
                            <th>Precio Mayorista</th>
                            <th>Stock</th>
                            <th>Unidad</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        {filteredProducts.length === 0 ? (
                            <tr>
                                <td colSpan={7} style={{ textAlign: 'center', padding: '2rem', color: 'var(--text-secondary)' }}>
                                    No hay productos registrados.
                                </td>
                            </tr>
                        ) : (
                            filteredProducts.map((product) => (
                                <tr key={product.id}>
                                    <td style={{ fontWeight: 600 }}>{product.name}</td>
                                    <td>{product.category}</td>
                                    <td>${new Intl.NumberFormat('es-AR').format(product.priceRetail)}</td>
                                    <td>${new Intl.NumberFormat('es-AR').format(product.priceWholesale)}</td>
                                    <td style={{ color: product.stock < 10 ? 'var(--error)' : 'var(--text-main)' }}>
                                        {product.stock}
                                    </td>
                                    <td>{product.unit}</td>
                                    <td>
                                        <div style={{ display: 'flex', gap: '0.5rem' }}>
                                            <button
                                                onClick={() => handleEdit(product)}
                                                className="btn"
                                                style={{
                                                    padding: '6px 12px',
                                                    background: 'var(--surface-alt)',
                                                    color: 'var(--primary)',
                                                    border: '1px solid var(--border)',
                                                    fontSize: '0.85rem'
                                                }}
                                            >
                                                <Edit size={16} /> Editar
                                            </button>
                                            <button
                                                onClick={() => handleDelete(product.id)}
                                                className="btn"
                                                style={{
                                                    padding: '6px 12px',
                                                    background: '#fee2e2',
                                                    color: 'var(--error)',
                                                    border: 'none',
                                                    fontSize: '0.85rem'
                                                }}
                                            >
                                                <Trash2 size={16} />
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            ))
                        )}
                    </tbody>
                </table>
            </div>

            {isFormOpen && (
                <ProductForm
                    initialProduct={editingProduct}
                    onClose={() => setIsFormOpen(false)}
                />
            )}
        </>
    );
}
