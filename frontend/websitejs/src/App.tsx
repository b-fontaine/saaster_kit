import React from 'react';
import { Header } from './components/Header';
import { Hero } from './components/Hero';
import { Features } from './components/Features';
import { HowToUse } from './components/HowToUse';
import { Footer } from './components/Footer';
export function App() {
  return <div className="min-h-screen flex flex-col bg-gray-50">
      <Header />
      <main className="flex-grow">
        <Hero />
        <Features />
        <HowToUse />
      </main>
      <Footer />
    </div>;
}