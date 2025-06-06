import React from 'react';
import { Terminal } from 'lucide-react';
export function HowToUse() {
  return <section id="how-to-use" className="py-16 bg-gray-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-12">
          <h2 className="text-3xl font-bold text-gray-900 mb-4">
            Getting Started is Simple
          </h2>
          <p className="text-xl text-gray-600 max-w-3xl mx-auto">
            Fork the project, clone your repository, and launch with a single
            command.
          </p>
        </div>
        <div className="bg-white rounded-xl shadow-md overflow-hidden border border-gray-200 max-w-3xl mx-auto">
          <div className="bg-gray-800 px-4 py-3 flex items-center">
            <Terminal size={20} className="text-gray-400 mr-2" />
            <span className="text-gray-200 font-medium">Terminal</span>
          </div>
          <div className="p-6 bg-gray-900 text-gray-200 font-mono text-sm overflow-x-auto">
            <div className="mb-4">
              <span className="text-green-400">
                # Step 1: Fork the SaaSter Kit repository
              </span>
              <br />
              <span className="opacity-70">
                Visit https://github.com/b-fontaine/saaster_kit and click "Fork"
              </span>
            </div>
            <div className="mb-4">
              <span className="text-green-400">
                # Step 2: Clone your forked repository
              </span>
              <br />
              <span>
                git clone https://github.com/your-username/saaster_kit.git
              </span>
              <br />
              <span>cd saaster_kit</span>
            </div>
            <div className="mb-4">
              <span className="text-green-400">
                # Step 3: Launch the SaaSter Kit
              </span>
              <br />
              <span>docker compose -p saaster up -d</span>
            </div>
            <div>
              <span className="text-green-400">
                # That's it! Your SaaS infrastructure is now running
              </span>
            </div>
          </div>
        </div>
        <div className="mt-12 text-center">
          <p className="text-lg text-gray-700 mb-6">
            Comprehensive documentation is available in the repository README
            files.
          </p>
          <p className="text-lg text-gray-700">
            SaaSter Kit is completely free to use and includes example prompts
            for AI tools like Augment Code, Cursor, or Devin.
          </p>
        </div>
      </div>
    </section>;
}