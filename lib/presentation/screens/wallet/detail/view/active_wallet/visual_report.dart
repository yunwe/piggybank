import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:piggybank/app/service/format_string.dart';
import 'package:piggybank/domain/model/models.dart';
import 'package:piggybank/presentation/model/models.dart';
import 'package:piggybank/presentation/resources/resources.dart';

class VisualReport extends StatelessWidget {
  final Wallet wallet;
  final List<Transaction> transactions;

  const VisualReport({super.key, required this.wallet, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final VisualReportData data = VisualReportData(wallet: wallet, transactions: transactions);

    return Padding(
      padding: const EdgeInsets.all(AppPadding.p28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _TransactionBarChart(
            dataList: data.dataList,
            maxY: data.maxY,
            interval: data.interval,
            unit: data.unit,
          ),
          _shortReport
        ],
      ),
    );
  }

  Widget get _shortReport {
    if (wallet.targetEndDate == null) {
      final report = Report(wallet: wallet);
      return Text(AppStrings.avgSaving.format([report.averageSaving.toStringAsFixed(2)]));
    }

    TargetReport report = TargetReport(wallet: wallet);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(AppStrings.labelGoal.format([report.amountToSave.toStringAsFixed(2)])),
        Text(AppStrings.labelCurrent.format([report.averageSaving.toStringAsFixed(2)])),
      ],
    );
  }
}

class _TransactionBarChart extends StatefulWidget {
  const _TransactionBarChart({
    required this.dataList,
    required this.maxY,
    required this.interval,
    this.unit,
  });

  final rodColor = Colors.green;
  final shadowColor = Colors.red;

  final List<RodData> dataList;
  final double maxY;
  final double interval;
  final String? unit;

  @override
  State<_TransactionBarChart> createState() => _TransactionBarChartState();
}

class _TransactionBarChartState extends State<_TransactionBarChart> {
  BarChartGroupData generateBarGroup(
    int x,
    double value,
    double shadowValue,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: widget.rodColor,
          width: 6,
        ),
        BarChartRodData(
          toY: shadowValue,
          color: widget.shadowColor,
          width: 6,
        ),
      ],
      showingTooltipIndicators: touchedGroupIndex == x ? [0] : [],
    );
  }

  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          borderData: FlBorderData(
            show: true,
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Colors.blueGrey.withOpacity(0.2),
              ),
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
              drawBelowEverything: true,
              sideTitles: SideTitles(
                interval: widget.interval,
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt().toString()}${widget.unit ?? ''}',
                    textAlign: TextAlign.left,
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(widget.dataList[index].title),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(),
            topTitles: const AxisTitles(),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: widget.interval,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.blueGrey.withOpacity(0.2),
              strokeWidth: 1,
            ),
          ),
          barGroups: widget.dataList.asMap().entries.map((e) {
            final index = e.key;
            final data = e.value;
            return generateBarGroup(
              index,
              data.saving,
              data.withdrawl,
            );
          }).toList(),
          maxY: widget.maxY,
          barTouchData: BarTouchData(
            enabled: true,
            handleBuiltInTouches: false,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => Colors.transparent,
              tooltipMargin: 0,
              getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
              ) {
                return BarTooltipItem(
                  rod.toY.toString(),
                  TextStyle(
                    fontWeight: FontWeight.bold,
                    color: rod.color,
                    fontSize: 18,
                    shadows: const [
                      Shadow(
                        color: Colors.black26,
                        blurRadius: 12,
                      )
                    ],
                  ),
                );
              },
            ),
            touchCallback: (event, response) {
              if (event.isInterestedForInteractions && response != null && response.spot != null) {
                setState(() {
                  touchedGroupIndex = response.spot!.touchedBarGroupIndex;
                });
              } else {
                setState(() {
                  touchedGroupIndex = -1;
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
