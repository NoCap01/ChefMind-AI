# ChefMind Performance Testing

This directory contains comprehensive performance testing tools for the ChefMind AI application.

## Overview

The performance testing system includes:

- **Performance Monitoring**: Real-time performance metrics collection
- **Memory Leak Detection**: Automated memory leak detection during app usage
- **UI Performance Testing**: Frame rate and responsiveness testing
- **Analytics Integration**: Production performance monitoring
- **Automated Reporting**: HTML reports with detailed performance analysis

## Running Performance Tests

### Quick Start

```bash
# Run all performance tests
flutter test integration_test/performance_test_runner.dart

# Run specific test suite
flutter test test/performance/performance_test_suite.dart
flutter test test/performance/memory_leak_detector.dart
flutter test test/performance/ui_performance_test.dart
```

### Using the Performance Script

```bash
# Run comprehensive performance testing with report generation
dart scripts/run_performance_tests.dart
```

This will:
1. Execute all performance tests
2. Collect performance metrics
3. Generate an HTML report in `test_results/performance_report.html`

## Performance Metrics

### Tracked Metrics

- **App Startup Time**: Time from app launch to first interactive screen
- **Recipe Generation Time**: Time to generate recipes using AI services
- **Navigation Performance**: Time to switch between screens
- **Memory Usage**: Memory consumption during various operations
- **UI Responsiveness**: Frame rates and input response times
- **Network Performance**: API call response times
- **Cache Performance**: Data loading and caching efficiency

### Performance Thresholds

| Metric | Good | Warning | Poor |
|--------|------|---------|------|
| App Startup | < 2.4s | 2.4s - 3s | > 3s |
| Recipe Generation | < 8s | 8s - 10s | > 10s |
| Navigation | < 400ms | 400ms - 500ms | > 500ms |
| Memory Increase (Navigation) | < 16MB | 16MB - 20MB | > 20MB |
| Frame Rate | > 50 FPS | 30-50 FPS | < 30 FPS |

## Test Files

### Core Test Files

- `performance_test_suite.dart`: Main performance test suite
- `memory_leak_detector.dart`: Memory leak detection tests
- `ui_performance_test.dart`: UI performance and responsiveness tests
- `performance_test_runner.dart`: Integration test runner

### Supporting Files

- `../core/performance/performance_monitor.dart`: Performance monitoring service
- `../core/analytics/analytics_service.dart`: Analytics and metrics collection
- `../core/performance/performance_optimizer.dart`: Performance optimization utilities
- `../core/performance/performance_config.dart`: Performance configuration and thresholds

## Performance Dashboard

The app includes a built-in performance dashboard for debugging:

```dart
// Navigate to performance dashboard (debug builds only)
Navigator.push(context, MaterialPageRoute(
  builder: (context) => PerformanceDashboardScreen(),
));
```

## Production Monitoring

### Analytics Integration

The app automatically tracks performance metrics in production:

```dart
// Track custom performance metrics
AnalyticsService().trackPerformanceMetric('custom_operation', duration);

// Track user actions with performance context
AnalyticsService().trackUserAction('recipe_generated', {
  'generation_time': duration,
  'success': true,
});
```

### Performance Optimization

The app includes several performance optimizations:

- **Lazy Loading**: Lists and images load on demand
- **Memory Management**: Automatic cleanup of unused resources
- **Caching**: Intelligent caching of API responses and images
- **State Optimization**: Minimized widget rebuilds
- **Image Optimization**: Compressed and cached images

## Continuous Integration

### GitHub Actions Integration

Add this to your `.github/workflows/performance.yml`:

```yaml
name: Performance Tests
on: [push, pull_request]

jobs:
  performance:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test integration_test/performance_test_runner.dart
      - run: dart scripts/run_performance_tests.dart
      - uses: actions/upload-artifact@v2
        with:
          name: performance-report
          path: test_results/
```

## Troubleshooting

### Common Issues

1. **Tests Timeout**: Increase timeout values in test configuration
2. **Memory Tests Fail on Web**: Memory tests are skipped on web platform
3. **Frame Rate Tests Inconsistent**: Run on physical devices for accurate results
4. **Network Tests Fail**: Ensure stable internet connection

### Debug Mode vs Release Mode

- Performance tests should be run in **profile mode** for accurate results
- Debug mode includes additional overhead that affects performance metrics
- Use `flutter run --profile` for performance testing

### Platform Differences

- iOS and Android may have different performance characteristics
- Web platform has limitations for memory testing
- Desktop platforms may show different performance patterns

## Best Practices

1. **Run tests on real devices** for accurate performance metrics
2. **Test on different device specifications** (low-end, mid-range, high-end)
3. **Monitor performance over time** to catch regressions
4. **Set up automated performance testing** in CI/CD pipeline
5. **Review performance reports regularly** and address issues promptly

## Contributing

When adding new performance tests:

1. Follow the existing test structure
2. Add appropriate performance thresholds
3. Include both positive and negative test cases
4. Document any new metrics or thresholds
5. Update this README with new test information

## Resources

- [Flutter Performance Best Practices](https://flutter.dev/docs/perf/best-practices)
- [Flutter Performance Profiling](https://flutter.dev/docs/perf/rendering/ui-performance)
- [Integration Testing in Flutter](https://flutter.dev/docs/cookbook/testing/integration/introduction)