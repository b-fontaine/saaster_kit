import React from 'react';
import { Shield, Layers, Lock, Workflow, Code, BarChart } from 'lucide-react';
export function Features() {
  const features = [{
    title: 'Enhanced Security Stack',
    description: 'SafeLine WAF integration provides advanced protection against SQL injection, XSS, DoS attacks, bot threats, and OWASP Top 10 vulnerabilities.',
    icon: <Shield className="h-8 w-8 text-indigo-600" />
  }, {
    title: 'Frontend Applications',
    description: 'Flutter-based cross-platform solutions with Material UI and atomic design pattern for web, mobile, and desktop.',
    icon: <Layers className="h-8 w-8 text-indigo-600" />
  }, {
    title: 'API Gateway & Security',
    description: 'Kong Enterprise API Gateway for routing, authentication, rate limiting, and protocol translation plus SafeLine WAF for threat detection.',
    icon: <Shield className="h-8 w-8 text-indigo-600" />
  }, {
    title: 'Identity & Access Management',
    description: 'Keycloak provides enterprise-grade authentication, authorization, and multi-tenant user management with role-based access control.',
    icon: <Lock className="h-8 w-8 text-indigo-600" />
  }, {
    title: 'Workflow Orchestration',
    description: 'Temporal delivers a reliable workflow engine for complex business logic with comprehensive monitoring and management interface.',
    icon: <Workflow className="h-8 w-8 text-indigo-600" />
  }, {
    title: 'Microservices Architecture',
    description: 'Go-based services with hexagonal architecture, database-per-service pattern, and gRPC communication with REST API translation.',
    icon: <Code className="h-8 w-8 text-indigo-600" />
  }, {
    title: 'Complete Observability',
    description: 'Production-ready monitoring and logging with Prometheus, Grafana, and Elasticsearch for centralized logging and trace analysis.',
    icon: <BarChart className="h-8 w-8 text-indigo-600" />
  }];
  return <section id="features" className="py-16 bg-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-16">
          <h2 className="text-3xl font-bold text-gray-900 mb-4">
            Comprehensive Features
          </h2>
          <p className="text-xl text-gray-600 max-w-3xl mx-auto">
            SaaSter Kit provides everything you need to build, deploy, and scale
            your SaaS application.
          </p>
        </div>
        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
          {features.map((feature, index) => <div key={index} className="bg-white rounded-lg p-6 border border-gray-200 shadow-sm hover:shadow-md transition-shadow">
              <div className="mb-4">{feature.icon}</div>
              <h3 className="text-xl font-semibold mb-2 text-gray-900">
                {feature.title}
              </h3>
              <p className="text-gray-600">{feature.description}</p>
            </div>)}
        </div>
      </div>
    </section>;
}