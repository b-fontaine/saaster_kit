import React from 'react';
import { Github } from 'lucide-react';
export function Footer() {
  return <footer className="bg-gray-900 text-white py-12">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex flex-col md:flex-row justify-between items-center">
          <div className="mb-6 md:mb-0">
            <div className="text-2xl font-bold text-white mb-2">
              SaaSter Kit
            </div>
            <p className="text-gray-400">
              A free, open-source starter kit for SaaS applications
            </p>
          </div>
          <div className="flex flex-col items-center md:items-end">
            <a href="https://github.com/b-fontaine/saaster_kit" target="_blank" rel="noreferrer" className="flex items-center text-white hover:text-indigo-300 transition-colors mb-2">
              <Github size={20} className="mr-2" />
              <span>GitHub Repository</span>
            </a>
            <p className="text-gray-400 text-sm">
              This project is not for sale and is completely free to use.
            </p>
          </div>
        </div>
      </div>
    </footer>;
}