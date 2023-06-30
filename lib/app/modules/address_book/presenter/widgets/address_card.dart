import 'package:flutter/material.dart';

import '../../domain/entities/address.dart';

class AddressCard extends StatefulWidget {
  const AddressCard({
    super.key,
    this.selected = false,
    required this.address,
    this.onTap,
    this.onFavorite,
    this.onDelete,
    this.showFavorite = false,
  });

  final bool selected;
  final Address address;
  final VoidCallback? onTap;
  final Function(int)? onDelete;
  final Function(Address)? onFavorite;
  final bool showFavorite;

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  late double visible = widget.address.isFavorite ? 0.3 : 1.0;

  @override
  void initState() {
    super.initState();

    if (widget.address.isFavorite) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (mounted) setState(() => visible = 1.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible,
      duration: const Duration(milliseconds: 300),
      child: Card(
        elevation: 3,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: widget.onTap,
                        child: Material(
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.all(5.0),
                                child: Image.asset('assets/icons/map_mark_icon.png', fit: BoxFit.scaleDown),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Visibility(
                                      visible: widget.address.title.isNotEmpty,
                                      child: Text(
                                        widget.address.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            '${widget.address.streetAddress}, ${widget.address.streetAddressNumber}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: widget.address.additionalAddress.isNotEmpty,
                                      child: Text(
                                        '(${widget.address.additionalAddress.toLowerCase()})',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${widget.address.district}, ${widget.address.city} - ${widget.address.state}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (widget.onDelete != null) ? () => widget.onDelete!(widget.address.id) : null,
                      icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: widget.showFavorite,
                child: Positioned(
                  top: 0,
                  right: 0,
                  child: Material(
                    color: Colors.transparent,
                    clipBehavior: Clip.antiAlias,
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: (widget.onFavorite != null)
                          ? () async {
                              setState(() => visible = 0.0);

                              await Future.delayed(const Duration(milliseconds: 300));

                              widget.onFavorite!(widget.address);
                            }
                          : null,
                      splashColor: !widget.address.isFavorite
                          ? Colors.yellow.shade700.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.3),
                      highlightColor: Colors.white24,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          widget.address.isFavorite ? Icons.star : Icons.star_border_outlined,
                          color: widget.address.isFavorite ? Colors.yellow.shade700 : Colors.black38,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
