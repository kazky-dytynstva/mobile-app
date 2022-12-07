# Widget conventions

- every widget should serve single goal (`S` from `SOLID`)!
- if it becomes big, messy, unclear - its time to split it.
- sometimes it make sense to create private widget (`_InternalWidget`), but do not abuse it

-----------

## Table of content:

1) [Folder structure](#folder-structure)
2) [Widget tree](#widget-tree)
3) [Naming](../docs/NAMING_CONVENTIONS.md)

-----------

### Folder structure

- for every screen use different folder under `lib -> presentation -> view -> screen_name`
- common widgets, that are used through the different screens should be stored
  under `lib -> presentation -> widgets`
    - they might be also stored under specialized folder: `../ -> widgets -> buttons`
- screen-related widgets should be stored in `widget` folder under the `screen`
  folder: `../ -> screen_name -> widgets`
    - they might be also stored under specialized folder: `../ -> screen_name -> widgets -> buttons`
- as soon as more than 1 screen require some widget - it should be moved to
  the `lib -> presentation -> widgets`

-----------

### Widget tree

It's much easier to read/understand/refactor widget tree without huge amount of nested children.

- the widget tree should be with **3 or less** nested children
    <details>
        <summary>Example</summary>

    ```dart
        //bad ❌
        //Scaffold -> CustomSnackBarPane -> BlocBuilder -> Stack -> ChangeNotifierProvider -> Child
        return Scaffold(
          body: CustomSnackBarPane(
            bottomWidgetKey: _bottomMenuGlobalKey,
            child: BlocBuilder<WebViewManager, WebViewState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    buildBody(state),
                    ChangeNotifierProvider.value(
                      value: _webViewBottomBarController,
                      builder: (context, _) => buildBottomMenu(state),
                    ),
                  ],
                );
              },
            ),
          ),
        );
    
        //good ✅
        //BlocBuilder -> Stack -> Child
        final blockBuilder = BlocBuilder<WebViewManager, WebViewState>(   // #1
          builder: (context, state) => Stack(                             // #2
            children: [
              buildBody(state),                                           // #3  
              buildBanner(state),                                         // #3            
            ],
          ),
        );
    
        //Scaffold -> CustomSnackBarPane -> blockBuilder
        return Scaffold(                                                  // #1
          body: CustomSnackBarPane(                                       // #2
            bottomWidgetKey: _bottomMenuGlobalKey,
            child: blockBuilder,                                          // #3
          ),
        );
    ```
    </details>

- create local variables - use them later
    <details>
        <summary>Example</summary>

    ```dart
        //bad ❌
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Positioned(
                  child: Text("first kid"),
                ),
                Positioned(
                  child: CloseButton(
                    onPressed: () {},
                  ),
                )
              ],
            )
          ],
        );
    
        //good ✅
        final positionText = Positioned(
          child: Text("first kid"),
        );
        final positionedBtn = Positioned(
          child: CloseButton(
            onPressed: () {},
          ),
        );
    
        final stack = Stack(
          children: [positionText, positionedBtn],
        );
    
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            stack,
          ],
        );
    ```
    </details>

- create methods inside methods
    <details>
        <summary>Example</summary>

    ```dart
        //bad ❌
        CustomSnackBarPane(
          bottomWidgetKey: _bottomMenuGlobalKey,
          child: BlocBuilder<WebViewManager, WebViewState>(
            builder: (context, state) {
              return Stack(
                children: [
                  buildBody(state),
                  ChangeNotifierProvider.value(
                    value: _webViewBottomBarController,
                    builder: (context, _) => buildBottomMenu(state),
                  ),
                ],
              );
            },
          ),
        );
    
        //good ✅
        Widget createStateBuilder(_, WebViewState state) => Stack(
              children: [
                buildBody(state),
                buildBanner(state),
              ],
            );
    
        return CustomSnackBarPane(
          bottomWidgetKey: _bottomMenuGlobalKey,
          child: BlocBuilder<WebViewManager, WebViewState>(builder: createStateBuilder),
        );
    ```
    </details>

- if method is already big enough - _take some children widget out_ or even to the _separate widget_
  file

-----------