import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture/core/utils/service_locator.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_texts.dart';
import '../../../../core/utils/constants.dart';
import '../../../home/presentation/cubit/all_products/all_products_cubit.dart';
import '../../../home/presentation/cubit/categories/categories_cubit.dart';
import '../../../home/services/get_all_products_service.dart';
import '../widgets/search_view_body.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AllProductsCubit>()..fetchAllProducts(),
        ),
        BlocProvider(
          create: (context) => getIt<CategoriesCubit>()..fetchCategories(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            color: AppColors.white,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        AllProductsService().setSearchQuery('');
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(
                            AppConstants.defaultBorderRadius,
                          ),
                        ),
                        child: TextField(
                          cursorColor: AppColors.black,
                          controller: _searchController,
                          focusNode: _searchFocus,
                          onChanged: (value) {
                            AllProductsService().setSearchQuery(value);
                          },
                          decoration: InputDecoration(
                            hintText: AppTexts.searchFieldHint,
                            suffixIcon: _searchController.text.isEmpty
                                ? IconButton(
                                    onPressed: () {
                                      _searchController.clear();
                                      AllProductsService().setSearchQuery('');
                                    },
                                    icon: const Icon(
                                      Icons.clear,
                                      color: AppColors.grey,
                                    ),
                                  )
                                : null,
                            prefixIcon: const Icon(
                              Icons.search,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SearchViewBody(
          searchController: _searchController,
        ),
      ),
    );
  }
}
