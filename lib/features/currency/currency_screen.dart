import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../services/currency_service.dart';
import '../../services/history_service.dart';
import '../../models/calculation_history.dart';
import '../../widgets/currency_display.dart';
import '../../widgets/numeric_keypad.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/gradient_button.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({Key? key}) : super(key: key);

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final CurrencyService _currencyService = CurrencyService();
  final HistoryService _historyService = HistoryService();

  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  String _amount = '0';
  double _convertedAmount = 0.0;
  double _exchangeRate = 0.0;

  bool _isLoading = false;
  late List<String> _currencies;

  @override
  void initState() {
    super.initState();
    _currencies = _currencyService.getSupportedCurrencies();
    _convert();
  }

  // --------------------------------------------------
  // 🔹 Keypad Input Handling
  // --------------------------------------------------

  void _onKeypadInput(String value) {
    setState(() {
      if (value == 'DEL') {
        if (_amount.length > 1) {
          _amount = _amount.substring(0, _amount.length - 1);
        } else {
          _amount = '0';
        }
      } else if (value == '.') {
        if (!_amount.contains('.')) {
          _amount += value;
        }
      } else {
        if (_amount == '0') {
          _amount = value;
        } else {
          _amount += value;
        }
      }
    });

    _convert();
  }

  // --------------------------------------------------
  // 🔹 Conversion Logic (Live API)
  // --------------------------------------------------

  Future<void> _convert() async {
    if (_amount.isEmpty) return;

    final parsedAmount = double.tryParse(_amount);
    if (parsedAmount == null) return;

    setState(() => _isLoading = true);

    try {
      final rate = await _currencyService.getExchangeRateInstance(
        _fromCurrency,
        _toCurrency,
      );

      setState(() {
        _exchangeRate = rate;
        _convertedAmount = parsedAmount * rate;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to fetch exchange rate'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // --------------------------------------------------
  // 🔹 Swap Currencies
  // --------------------------------------------------

  void _swapCurrencies() {
    setState(() {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
    });

    _convert();
  }

  // --------------------------------------------------
  // 🔹 Save To History
  // --------------------------------------------------

  void _saveConversion() {
    if (_amount == '0') return;

    final history = CalculationHistory(
      type: 'Currency',
      title: 'Currency Conversion',
      value: '$_amount $_fromCurrency',
      details:
          '${_convertedAmount.toStringAsFixed(2)} $_toCurrency (Rate: $_exchangeRate)',
    );

    _historyService.addCalculation(history);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Conversion saved'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  // --------------------------------------------------
  // 🔹 UI
  // --------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final fromSymbol =
        _currencyService.getCurrencySymbol(_fromCurrency);
    final toSymbol =
        _currencyService.getCurrencySymbol(_toCurrency);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Currency Converter'),
        elevation: 0,
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: _saveConversion,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GlassCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _CurrencySelector(
                            label: 'From',
                            currency: _fromCurrency,
                            currencies: _currencies,
                            onChanged: (value) {
                              setState(() => _fromCurrency = value);
                              _convert();
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: _swapCurrencies,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.swap_horiz,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _CurrencySelector(
                            label: 'To',
                            currency: _toCurrency,
                            currencies: _currencies,
                            onChanged: (value) {
                              setState(() => _toCurrency = value);
                              _convert();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (!_isLoading)
                      Text(
                        '1 $_fromCurrency = ${_exchangeRate.toStringAsFixed(4)} $_toCurrency',
                        style: AppTextStyles.bodySmall,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              CurrencyDisplay(
                currency: _fromCurrency,
                amount: _amount,
                symbol: fromSymbol,
              ),
              const SizedBox(height: 16),
              const Icon(Icons.arrow_downward,
                  color: AppColors.primary),
              const SizedBox(height: 16),
              CurrencyDisplay(
                currency: _toCurrency,
                amount: _isLoading
                    ? '...'
                    : _convertedAmount.toStringAsFixed(2),
                symbol: toSymbol,
              ),
              const SizedBox(height: 32),
              NumericKeypad(onInput: _onKeypadInput),
              const SizedBox(height: 32),
              GradientButton(
                label: 'Save Conversion',
                onPressed: _saveConversion,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurrencySelector extends StatelessWidget {
  final String label;
  final String currency;
  final List<String> currencies;
  final ValueChanged<String> onChanged;

  const _CurrencySelector({
    required this.label,
    required this.currency,
    required this.currencies,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodySmall),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: DropdownButton<String>(
            value: currency,
            onChanged: (value) => onChanged(value ?? currency),
            items: currencies
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            underline: const SizedBox.shrink(),
            isExpanded: true,
            dropdownColor: AppColors.surface,
            style: AppTextStyles.body,
          ),
        ),
      ],
    );
  }
}