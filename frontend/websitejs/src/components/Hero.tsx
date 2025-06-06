import React from 'react';
import { Github } from 'lucide-react';
export function Hero() {
  return <div className="bg-gradient-to-r from-indigo-600 to-purple-600 text-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 md:py-24">
        <div className="grid md:grid-cols-2 gap-8 items-center">
          <div>
            <h1 className="text-4xl md:text-5xl font-bold mb-4">
              Launch Your SaaS Faster with SaaSter Kit
            </h1>
            <p className="text-xl mb-8 text-indigo-100">
              A complete, production-ready starter kit for building modern SaaS
              applications. Focus on your business logic, we've handled the
              infrastructure.
            </p>
            <div className="flex flex-wrap gap-4">
              <a href="https://github.com/b-fontaine/saaster_kit" target="_blank" rel="noreferrer" className="flex items-center bg-white text-indigo-600 px-6 py-3 rounded-lg font-medium shadow-lg hover:bg-gray-100 transition-colors">
                <Github size={20} className="mr-2" />
                Fork on GitHub
              </a>
              <a href="#features" className="bg-transparent border-2 border-white text-white px-6 py-3 rounded-lg font-medium hover:bg-white hover:text-indigo-600 transition-colors">
                Explore Features
              </a>
            </div>
          </div>
          <div className="hidden md:block">
            <div className="bg-white/10 backdrop-blur-sm rounded-xl p-6 shadow-xl border border-white/20">
              <pre className="text-indigo-100 overflow-x-auto">
                <code>{`# Get started in seconds
$ git clone your-fork-url
$ docker compose -p saaster up -d
# Ready to customize and deploy!`}</code>
              </pre>
            </div>
          </div>
        </div>
      </div>
    </div>;
}