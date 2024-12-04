import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String txt;
  const CustomButton({super.key, required this.onTap, required this.txt});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            txt,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class CustomButtonIcon extends StatefulWidget {
  final void Function()? onTap;
  final String txt;
  final IconData? icon;
  final String? imagePath; // เพิ่มพารามิเตอร์สำหรับ path ของ PNG
  final double width;
  final double height;

  const CustomButtonIcon({
    super.key,
    required this.onTap,
    required this.txt,
    this.icon,
    this.imagePath,
    this.width = 200,
    this.height = 80,
  });

  @override
  State<CustomButtonIcon> createState() => _CustomButtonIconState();
}

class _CustomButtonIconState extends State<CustomButtonIcon> {
  bool _isHovered = false; // เก็บสถานะ hover หรือ click

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _isHovered = true; // เปลี่ยนสีเมื่อคลิก
          });
        },
        onTapUp: (_) {
          setState(() {
            _isHovered = false; // คืนค่าสีเมื่อคลิกเสร็จ
          });
          if (widget.onTap != null) widget.onTap!();
        },
        onTapCancel: () {
          setState(() {
            _isHovered = false; // คืนค่าสีเมื่อยกเลิกคลิก
          });
        },
        child: Container(
          width: widget.width,
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: _isHovered ? Colors.black : Colors.white, // สีพื้นหลัง
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.black, width: 1.5), // ขอบสีดำ
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.imagePath != null)
                  Image.asset(
                    widget.imagePath!,
                    width: 24,
                    height: 24,
                    color: _isHovered ? Colors.white : Colors.black,
                  ),
                if (widget.icon != null)
                  Icon(
                    widget.icon,
                    color: _isHovered ? Colors.white : Colors.black,
                    size: 24,
                  ),
                if (widget.icon != null || widget.imagePath != null)
                  const SizedBox(width: 10), // ระยะห่างระหว่างไอคอนกับข้อความ
                Text(
                  widget.txt,
                  style: TextStyle(
                    color: _isHovered ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
