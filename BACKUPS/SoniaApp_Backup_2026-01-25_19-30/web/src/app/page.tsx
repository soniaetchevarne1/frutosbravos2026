import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import Link from 'next/link';
import { Leaf, Truck, Tag } from 'lucide-react';
import styles from './page.module.css';

export default function Home() {
  return (
    <>
      <Navbar />

      <main>
        {/* Hero Section */}
        <section className={styles.hero}>
          <div className="container">
            <div className={styles.heroContent}>
              <h1 className="h1" style={{ marginBottom: '1.5rem', color: 'var(--primary)' }}>
                Nutrición Natural <br /> para tu Vida
              </h1>
              <p className="body-lg" style={{ marginBottom: '2rem', maxWidth: '600px', color: 'var(--text-secondary)' }}>
                Descubrí nuestra selección premium de frutos secos, especias y harinas. Venta minorista y mayorista con envíos a todo el país.
              </p>
              <div style={{ display: 'flex', gap: '1rem', flexWrap: 'wrap' }}>
                <Link href="/tienda" className="btn btn-primary">
                  Comprar Ahora
                </Link>
                <Link href="/mayorista" className="btn btn-secondary">
                  Soy Mayorista
                </Link>
              </div>
            </div>
          </div>
        </section>

        {/* Value Props */}
        <section className="section" style={{ background: 'var(--surface-alt)' }}>
          <div className="container">
            <div className={`grid-cols-3 ${styles.propsGrid}`}>
              <div className={styles.propCard}>
                <div className={styles.propIcon}><Leaf size={32} /></div>
                <h3 className="h3" style={{ marginBottom: '1rem' }}>100% Natural</h3>
                <p style={{ color: 'var(--text-secondary)' }}>Productos seleccionados sin conservantes ni aditivos.</p>
              </div>
              <div className={styles.propCard}>
                <div className={styles.propIcon}><Tag size={32} /></div>
                <h3 className="h3" style={{ marginBottom: '1rem' }}>Precios Mayoristas</h3>
                <p style={{ color: 'var(--text-secondary)' }}>Accedé a descuentos exclusivos comprando en cantidad.</p>
              </div>
              <div className={styles.propCard}>
                <div className={styles.propIcon}><Truck size={32} /></div>
                <h3 className="h3" style={{ marginBottom: '1rem' }}>Envíos a todo el país</h3>
                <p style={{ color: 'var(--text-secondary)' }}>Recibí tu pedido en la puerta de tu casa o negocio.</p>
              </div>
            </div>
          </div>
        </section>

        {/* Featured - Placeholder */}
        <section className="section">
          <div className="container">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '3rem' }}>
              <h2 className="h2">Destacados</h2>
              <Link href="/tienda" style={{ color: 'var(--primary)', fontWeight: 600 }}>Ver todo &rarr;</Link>
            </div>

            <div className="grid-cols-4">
              {[1, 2, 3, 4].map((i) => (
                <div key={i} className="card">
                  <div style={{ height: '250px', background: '#F3F4F1', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#CBD5E1' }}>
                    {/* Placeholder for Product Image */}
                    <span>Imagen {i}</span>
                  </div>
                  <div style={{ padding: '1.5rem' }}>
                    <h3 style={{ fontSize: '1.1rem', fontWeight: 600, marginBottom: '0.5rem' }}>Producto {i}</h3>
                    <p style={{ color: 'var(--text-secondary)', fontSize: '0.9rem', marginBottom: '1rem' }}>1kg</p>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                      <span style={{ fontWeight: 700, fontSize: '1.25rem', color: 'var(--primary)' }}>$4.500</span>
                      <button className={styles.addBtn} aria-label="Agregar">+</button>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>
      </main>

      <Footer />
    </>
  );
}
