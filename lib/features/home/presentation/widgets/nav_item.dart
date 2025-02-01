import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final String title;
  final String description;
  const NavItem({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          child: InkWell(
            onTap: onTap,
            child: Material(
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              clipBehavior: Clip.antiAlias,
              elevation: 20,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                  size: 40,
                ),
              ),
            ),
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey[800],
              ),
          maxLines: 3,
        ),
        SizedBox(
          width: 50,
          child: Text(
            description,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.grey[800],
                  fontSize: 10,
                ),
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
