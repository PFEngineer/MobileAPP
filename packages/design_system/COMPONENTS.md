# Catálogo de componentes

Listagem de tudo que o `design_system` expõe, com o que cada item contém
(propriedades e variantes principais). Import único: `package:design_system/design_system.dart`.

Totais: **7 grupos de tokens** · **13 atoms** · **2 molecules** · **3 organisms**.

---

## Tokens (`src/tokens/`)

Fonte da verdade — componentes leem daqui, nunca de valores fixos.

| Token | Contém |
|---|---|
| `DsColors` | Paleta primitiva: `purple50…900`, `neutral0…900`, `green500`, `red500`, `orange500`, `blue500`. |
| `DsColorScheme` | Papéis semânticos: `primary` (+ hover/pressed/subtle/onPrimary), `secondary`, `success`/`danger`/`warning`/`info` (+ subtle/on), `background`, `surface`, `surfaceAlt`, `textPrimary/Secondary/Tertiary/Disabled/Inverse`, `border`/`borderStrong`/`borderFocus`, `disabledBackground/Foreground`, `overlay`. Factory `DsColorScheme.light()`, `copyWith`, `lerp`. |
| `DsSpacing` | Escala base 4px: `none`, `xs`(4), `sm`(8), `md`(12), `lg`(16), `xl`(20), `xl2`(24), `xl3`(32), `xl4`(40), `xl5`(48), `xl6`(64), `xl7`(80), `xl8`(96). |
| `DsRadius` | Raios: `xs`(4), `sm`(8), `md`(12), `lg`(16), `xl`(20), `xl2`(24), `full`(pill). Helpers `Radius` e `BorderRadius` prontos (`mdAll`, `fullAll`, …). |
| `DsTypography` | Família Inter + 8 estilos: `displayXl` (40/48 bold), `heading1` (30/40), `heading2` (24/32), `heading3` (20/28), `bodyLarge` (16/24), `bodyMedium` (14/20), `labelMedium` (12/16), `caption` (11/16). Pesos: `regular`/`medium`/`semiBold`/`bold`. |
| `DsElevation` | Sombras (`List<BoxShadow>`): `none`, `xs`, `sm`, `md`, `lg`, `xl`, `xl2`. |
| `DsIcons` | 16 ícones: `home`, `chart`, `wallet`, `bell`, `search`, `plus`, `minus`, `arrowRight`, `edit`, `trash`, `eye`, `heart`, `star`, `moreVertical`, `check`, `close`. |

## Tema (`src/theme/`)

| Item | Contém |
|---|---|
| `DsTheme` | `DsTheme.light()` → `ThemeData` (Material 3) montado a partir dos tokens. |
| `DsThemeExtension` | Carrega o `DsColorScheme` no tema; acesso via `context.dsColors` (fallback para o tema claro). |

---

## Atoms (`src/atoms/`)

| Componente | O que contém (props / variantes) |
|---|---|
| `DsButton` | `label`, `onPressed`. Variantes (`variant`): `primary`, `secondary`, `outline`, `text`, `destructive`. Tamanhos (`size`): `small`, `medium`, `large`. Extras: `icon`, `trailingIcon`, `isLoading`, `expanded`. Estados hover/pressed/disabled automáticos. |
| `DsTextField` | `controller`, `label`, `hint`, `helperText`, `errorText`, `prefixIcon`, `suffixIcon` (+ `onSuffixTap`), `onChanged`, `onSubmitted`, `obscureText`, `enabled`, `readOnly`, `keyboardType`, `textInputAction`, `maxLines`, `focusNode`. Estado de erro ao passar `errorText`. |
| `DsCheckbox` | `value`, `onChanged`, `label` opcional (linha inteira clicável). |
| `DsRadio<T>` | `value`, `groupValue`, `onChanged`, `label` opcional. Genérico no valor `T`. |
| `DsSwitch` | `value`, `onChanged`, `label` opcional (empurra o controle para a direita). |
| `DsAvatar` | `imageUrl` **ou** `initials`. Tamanhos: `sm`, `md`, `lg`, `xl`. `showStatus` + `statusColor` (dot de presença). |
| `DsBadge` | `DsBadge.count(count, tone, maxCount, child)` e `DsBadge.dot(tone, child)`. Ancora no canto do `child` quando informado. |
| `DsChip` | `label`, `selected`, `onSelected`, `onDeleted` (remove), `icon`. Chip de filtro/escolha. |
| `DsTag` | `label`, `tone`, `icon`, `solid` (alta ênfase vs. subtle). Rótulo não-interativo. |
| `DsStatus` | `label`, `tone`. Dot colorido + texto de estado. |
| `DsLinearProgress` | `value` (0..1 ou `null` = indeterminado), `height`. |
| `DsCircularProgress` | `value` (0..1 ou `null`), `size`, `strokeWidth`. |
| `DsIndicator` | `count`, `current`. Dots de página/step (o ativo alonga). |

**`DsTone`** (compartilhado por Tag/Badge/Status): `neutral`, `primary`, `success`, `danger`, `warning`, `info`.

---

## Molecules (`src/molecules/`)

| Componente | O que contém |
|---|---|
| `DsCard` | `child`, `padding`, `onTap` (torna clicável), `elevated`. Superfície com raio, borda e sombra dos tokens. |
| `DsListItem` | `title`, `subtitle`, `leading`, `trailing`, `onTap`. Linha de lista composável. |

---

## Organisms (`src/organisms/`)

| Componente | O que contém |
|---|---|
| `DsAppBar` | `title`, `leading`, `actions`, `centerTitle`. Implementa `PreferredSizeWidget` (56px + safe area). |
| `DsTabs` | `tabs` (`List<String>`), `selectedIndex`, `onChanged`. Segmentação estilo underline. |
| `DsBottomNavigation` | `items` (`DsBottomNavItem{ icon, label }`), `currentIndex`, `onChanged`. Barra inferior plana com destino ativo destacado. |

---

Para ver todos rodando de forma interativa: `make run-ds` (example app em `example/`).
