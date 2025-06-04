import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class DocumentationCard extends StatelessWidget {
  const DocumentationCard({super.key});

  static const String _documentationContent = '''
# Adding Features with AI Agents

Welcome to the comprehensive guide for adding features to your SaaS application using AI agents. This documentation will help you understand how to leverage AI-powered development tools to accelerate your development process.

## Getting Started

### Prerequisites
- Basic understanding of Flutter and Dart
- Familiarity with the SaaS architecture
- Access to AI development tools

### Setting Up Your Environment
1. **Clone the Repository**: Start by cloning the SaaS starter kit repository
2. **Install Dependencies**: Run `flutter pub get` to install all required packages
3. **Configure AI Tools**: Set up your preferred AI development assistant

## Best Practices

### Code Generation
- **Use Descriptive Prompts**: When asking AI to generate code, be specific about requirements
- **Review Generated Code**: Always review and test AI-generated code before integration
- **Follow Conventions**: Ensure generated code follows your project's coding standards

### Feature Development Workflow
1. **Define Requirements**: Clearly outline what the feature should accomplish
2. **Design Architecture**: Plan the component structure and data flow
3. **Generate Components**: Use AI to create initial component implementations
4. **Iterate and Refine**: Work with AI to improve and optimize the code
5. **Test Thoroughly**: Implement comprehensive testing for new features

### Integration Patterns
- **Microservices**: Leverage the existing microservice architecture
- **State Management**: Use flutter_bloc for consistent state management
- **Design System**: Always use the established design system components
- **API Integration**: Follow RESTful API patterns for backend communication

## Common Use Cases

### Adding New Dashboard Widgets
```dart
// Example: Creating a new metric widget
class MetricWidget extends StatelessWidget {
  const MetricWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DSCards.appCard(
      child: Column(
        children: [
          Icon(icon, size: 32, color: DSColors.primaryApp),
          DSSpacing.verticalSpacerSM,
          Text(title, style: DSTypography.appTextTheme.titleMedium),
          Text(value, style: DSTypography.appTextTheme.headlineSmall),
        ],
      ),
    );
  }
}
```

### Creating New API Endpoints
When adding new API endpoints, follow these patterns:
- Use proper HTTP methods (GET, POST, PUT, DELETE)
- Implement proper error handling
- Add authentication where required
- Document your endpoints

### Adding New Pages
1. Create the page widget in `lib/ui/pages/`
2. Add routing configuration in `app_router.dart`
3. Implement proper navigation
4. Add necessary state management

## Troubleshooting

### Common Issues
- **Import Errors**: Ensure all dependencies are properly imported
- **State Management**: Check that BLoC patterns are correctly implemented
- **Design System**: Verify that design system components are used consistently
- **API Integration**: Confirm that API endpoints are correctly configured

### Debugging Tips
- Use Flutter Inspector for UI debugging
- Implement proper logging throughout your application
- Use breakpoints effectively during development
- Test on multiple screen sizes and devices

## Advanced Topics

### Custom Widgets
When creating custom widgets:
- Follow the atomic design pattern
- Make widgets reusable and configurable
- Implement proper accessibility features
- Use const constructors where possible

### Performance Optimization
- Use const widgets to reduce rebuilds
- Implement proper list virtualization for large datasets
- Optimize image loading and caching
- Monitor memory usage and performance metrics

### Security Considerations
- Implement proper authentication and authorization
- Validate all user inputs
- Use HTTPS for all API communications
- Follow OWASP security guidelines

## Resources

### Documentation Links
- [Flutter Documentation](https://flutter.dev/docs)
- [Design System Guide](../design_system/README.md)
- [API Documentation](../backend/README.md)
- [Deployment Guide](../infra/README.md)

### Community Support
- Join our Discord community for real-time help
- Check Stack Overflow for common issues
- Contribute to our GitHub discussions
- Follow our blog for updates and tutorials

## Conclusion

AI agents can significantly accelerate your development process when used effectively. Remember to always review generated code, follow established patterns, and maintain high code quality standards. Happy coding!
''';

  @override
  Widget build(BuildContext context) {
    return DSCards.appElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GptMarkdown(
            _documentationContent,
            style: DSTypography.appTextTheme.bodyMedium?.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}
