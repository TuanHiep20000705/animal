part of 'widgets.dart';

class BBSBaseScaffold<T extends BBSBaseController> extends StatefulWidget {
  final T? controller;
  final Function(T controller)? initState;
  final Widget? child;
  final Widget Function(T controller)? builder;
  final Future<bool> Function()? onWillPop;
  final EdgeInsets? padding;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const BBSBaseScaffold({
    super.key,
    this.controller,
    this.initState,
    this.child,
    this.builder,
    this.onWillPop,
    this.padding,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.appBar,
    this.drawer,
    this.scaffoldKey
  });

  @override
  State<BBSBaseScaffold> createState() => _BBSBaseScaffoldState<T>();
}

class _BBSBaseScaffoldState<T extends BBSBaseController> extends State<BBSBaseScaffold<T>> {
  @override
  void initState() {
    if (widget.initState != null && widget.controller != null) {
      Future.delayed(Duration.zero, () async {
        widget.initState!(widget.controller!);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: widget.onWillPop,
        child: Scaffold(
          body: SafeArea(
              minimum: widget.padding ?? EdgeInsets.zero,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusScope.of(context).unfocus(),
                child: widget.controller == null
                  ? widget.child
                  :ChangeNotifierProvider<T>(
                    create: (context) =>widget.controller!..context = context,
                    builder: (context, child) => Consumer<T>(
                        builder: (context, controller, _) => widget.builder!(controller)
                    ),
                )
                ,
              )
          ),
          floatingActionButton: widget.floatingActionButton,
          bottomNavigationBar: widget.bottomNavigationBar,
          appBar: widget.appBar,
          drawer: widget.drawer,
          key: widget.scaffoldKey,
        ),
    );
  }
}
