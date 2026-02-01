import type { Metadata } from 'next';
import { Outfit } from 'next/font/google';
import './globals.css';
import { StoreProvider } from '@/context/StoreContext';

const outfit = Outfit({
  subsets: ['latin'],
  display: 'swap',
  variable: '--font-outfit',
  weight: ['300', '400', '500', '600', '700']
});

export const metadata: Metadata = {
  title: 'Sonia - Alimentos Saludables',
  description: 'Tienda online de productos naturales, frutos secos y bienestar.',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="es" className={outfit.variable}>
      <body>
        <StoreProvider>
          <div className="layout-wrapper">
            {children}
          </div>
        </StoreProvider>
      </body>
    </html>
  );
}
