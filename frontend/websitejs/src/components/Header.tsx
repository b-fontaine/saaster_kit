import React, { useState } from 'react';
import { Menu, X, Github } from 'lucide-react';
export function Header() {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  return <header className="bg-white shadow-sm sticky top-0 z-10">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center py-4">
          <div className="flex items-center">
            <span className="text-2xl font-bold text-indigo-600">
              SaaSter Kit
            </span>
          </div>
          <nav className="hidden md:flex space-x-8">
            <a href="#features" className="text-gray-700 hover:text-indigo-600 transition-colors">
              Features
            </a>
            <a href="#how-to-use" className="text-gray-700 hover:text-indigo-600 transition-colors">
              How to Use
            </a>
            <a href="https://github.com/b-fontaine/saaster_kit" target="_blank" rel="noreferrer" className="flex items-center text-gray-700 hover:text-indigo-600 transition-colors">
              <Github size={18} className="mr-1" />
              <span>GitHub</span>
            </a>
          </nav>
          <div className="md:hidden">
            <button onClick={() => setIsMenuOpen(!isMenuOpen)} className="text-gray-700 hover:text-indigo-600">
              {isMenuOpen ? <X size={24} /> : <Menu size={24} />}
            </button>
          </div>
        </div>
        {isMenuOpen && <div className="md:hidden py-2 pb-4">
            <a href="#features" className="block py-2 text-gray-700 hover:text-indigo-600" onClick={() => setIsMenuOpen(false)}>
              Features
            </a>
            <a href="#how-to-use" className="block py-2 text-gray-700 hover:text-indigo-600" onClick={() => setIsMenuOpen(false)}>
              How to Use
            </a>
            <a href="https://github.com/b-fontaine/saaster_kit" target="_blank" rel="noreferrer" className="flex items-center py-2 text-gray-700 hover:text-indigo-600" onClick={() => setIsMenuOpen(false)}>
              <Github size={18} className="mr-1" />
              <span>GitHub</span>
            </a>
          </div>}
      </div>
    </header>;
}