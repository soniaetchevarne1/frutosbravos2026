"use client";

import { useState, useEffect } from 'react';
import Navbar from '@/components/Navbar';
import Footer from '@/components/Footer';
import Link from 'next/link';
import { Leaf, Truck, Tag, ChevronLeft, ChevronRight } from 'lucide-react';
import styles from './page.module.css';

const HERO_IMAGES = [
  '/placeholder/blog-nuts.jpg',
  '/placeholder/almendras.jpg',
  '/placeholder/avellanas.jpg',
  '/placeholder/mix.jpg'
];

export default function Home() {
  const [currentImage, setCurrentImage] = useState(0);

  useEffect(() => {
    const timer = setInterval(() => {
      setCurrentImage((prev) => (prev + 1) % HERO_IMAGES.length);
    }, 5000);
    return () => clearInterval(timer);
  }, []);

  const nextSlide = () => setCurrentImage((prev) => (prev + 1) % HERO_IMAGES.length);
  const prevSlide = () => setCurrentImage((prev) => (prev - 1 + HERO_IMAGES.length) % HERO_IMAGES.length);

  return (
    <>
      <Navbar />

      <main>
        {/* Hero Section */}
        <section className={styles.hero}>
          {/* Background Images Layer */}
          <div className={styles.heroBackground}>
            {HERO_IMAGES.map((img, index) => (
              <div
                key={img}
                className={`${styles.heroSlide} ${index === currentImage ? styles.activeSlide : ''}`}
                style={{ backgroundImage: `url(${img})` }}
              />
            ))}
            <div className={styles.heroOverlay} />
          </div>

          <div className="container" style={{ position: 'relative', zIndex: 10 }}>
            <div className={styles.heroContent}>
              <h1 className="h1" style={{ marginBottom: '1.5rem', color: 'white', textShadow: '0 2px 10px rgba(0,0,0,0.3)' }}>
                Nutrición Natural <br /> <span style={{ color: 'var(--secondary)' }}>para tu Vida</span>
              </h1>
              <p className="body-lg" style={{ marginBottom: '2.5rem', maxWidth: '600px', color: 'rgba(255,255,255,0.9)', fontWeight: 500, textShadow: '0 1px 5px rgba(0,0,0,0.5)' }}>
                Descubrí nuestra selección premium de frutos secos, especias y harinas. Venta minorista y mayorista con envíos a todo el país.
              </p>
              <div style={{ display: 'flex', gap: '1.25rem', flexWrap: 'wrap' }}>
                <Link href="/tienda" className="btn btn-primary" style={{ padding: '1rem 2.5rem', fontSize: '1.1rem' }}>
                  Comprar Ahora
                </Link>
                <Link href="/mayorista" className="btn btn-secondary" style={{ padding: '1rem 2.5rem', fontSize: '1.1rem', background: 'white', color: 'var(--primary)', border: 'none' }}>
                  Soy Mayorista
                </Link>
              </div>
            </div>
          </div>

          {/* Slider Controls */}
          <div className={styles.sliderControls}>
            <button onClick={prevSlide} className={styles.sliderBtn}><ChevronLeft /></button>
            <div className={styles.sliderDots}>
              {HERO_IMAGES.map((_, i) => (
                <div
                  key={i}
                  className={`${styles.dot} ${i === currentImage ? styles.activeDot : ''}`}
                  onClick={() => setCurrentImage(i)}
                />
              ))}
            </div>
            <button onClick={nextSlide} className={styles.sliderBtn}><ChevronRight /></button>
          </div>
        </section>

        {/* Value Props */}
        <section className="section" style={{ background: '#fdfdfb', borderTop: '1px solid #eee' }}>
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
              <h2 className="h2">Nuestros Favoritos</h2>
              <Link href="/tienda" className="btn-text" style={{ color: 'var(--primary)', fontWeight: 700, fontSize: '1.1rem' }}>VER TODA LA TIENDA &rarr;</Link>
            </div>

            <div className="grid-cols-4">
              {[
                { name: 'Almendras Premium', price: '$12.000', img: '/placeholder/almendras.jpg' },
                { name: 'Nueces Mariposa', price: '$10.500', img: '/placeholder/nueces.jpg' },
                { name: 'Mix Energético', price: '$5.500', img: '/placeholder/mix.jpg' },
                { name: 'Castañas de Cajú', price: '$14.000', img: '/placeholder/castanas.jpg' }
              ].map((prod, i) => (
                <div key={i} className="card" style={{ overflow: 'hidden', border: '1px solid #eee' }}>
                  <div style={{ height: '220px', overflow: 'hidden' }}>
                    <img src={prod.img} alt={prod.name} style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
                  </div>
                  <div style={{ padding: '1.5rem' }}>
                    <h3 style={{ fontSize: '1.1rem', fontWeight: 800, marginBottom: '0.25rem' }}>{prod.name}</h3>
                    <p style={{ color: 'var(--text-secondary)', fontSize: '0.85rem', marginBottom: '1rem', fontWeight: 600 }}>Cosecha Seleccionada</p>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                      <span style={{ fontWeight: 800, fontSize: '1.25rem', color: 'var(--primary)' }}>{prod.price}</span>
                      <Link href="/tienda" className={styles.addBtn} style={{ textDecoration: 'none' }}>+</Link>
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
