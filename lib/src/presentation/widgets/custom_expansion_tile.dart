import 'package:flutter/material.dart';

import '../../core/utils/utils.dart';

class CustomExpansionTile extends StatefulWidget {
  final Widget leading;
  final String name;
  final String job;
  final String admissionDate;
  final String phone;
  final bool isLastIndex;

  const CustomExpansionTile({
    super.key,
    required this.leading,
    required this.name,
    required this.job,
    required this.admissionDate,
    required this.phone,
    required this.isLastIndex,
  });

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _toggleExpansion,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Row(
              children: [
                widget.leading,
                const SizedBox(width: 14),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Color(0XFF0500FF),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Column(
              spacing: 6,
              children: [
                Row(
                  children: [
                    Text(
                      'Cargo',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(widget.job),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Data de admissão',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(Utils.formatDate(widget.admissionDate)),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Telefone',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      Utils.formatPhoneNumber(widget.phone),
                    ),
                  ],
                ),
              ],
            ),
          ),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
        if (!widget.isLastIndex) const Divider(),
      ],
    );
  }
}
