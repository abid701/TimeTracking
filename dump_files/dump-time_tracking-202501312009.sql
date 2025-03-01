PGDMP  $    	                 }            time_tracking    17.2    17.2 <    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16388    time_tracking    DATABASE     y   CREATE DATABASE time_tracking WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE time_tracking;
                     postgres    false            �           0    0    DATABASE time_tracking    ACL     .   GRANT ALL ON DATABASE time_tracking TO admin;
                        postgres    false    3493                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                     pg_database_owner    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                        pg_database_owner    false    4            Y           1247    16409    employee_role    TYPE     q   CREATE TYPE public.employee_role AS ENUM (
    'developer',
    'manager',
    'admin',
    'hr',
    'other'
);
     DROP TYPE public.employee_role;
       public               postgres    false    4            q           1247    16516    leave_reason_type    TYPE     j   CREATE TYPE public.leave_reason_type AS ENUM (
    'sick',
    'vacation',
    'personal',
    'other'
);
 $   DROP TYPE public.leave_reason_type;
       public               postgres    false    4            n           1247    16509    leave_status_type    TYPE     ^   CREATE TYPE public.leave_status_type AS ENUM (
    'pending',
    'approved',
    'denied'
);
 $   DROP TYPE public.leave_status_type;
       public               postgres    false    4            _           1247    16433    status    TYPE     T   CREATE TYPE public.status AS ENUM (
    'ongoing',
    'completed',
    'paused'
);
    DROP TYPE public.status;
       public               postgres    false    4            e           1247    16456    task_status_type    TYPE     `   CREATE TYPE public.task_status_type AS ENUM (
    'todo',
    'in progress',
    'completed'
);
 #   DROP TYPE public.task_status_type;
       public               postgres    false    4            �            1259    16542    clients    TABLE     �   CREATE TABLE public.clients (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    contact_email character varying(255),
    phone character varying(20),
    company_name character varying(255),
    address text
);
    DROP TABLE public.clients;
       public         heap r       postgres    false    4            �            1259    16541    clients_id_seq    SEQUENCE     �   CREATE SEQUENCE public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.clients_id_seq;
       public               postgres    false    228    4            �           0    0    clients_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;
          public               postgres    false    227            �            1259    16420 	   employees    TABLE     �  CREATE TABLE public.employees (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    role public.employee_role DEFAULT 'other'::public.employee_role,
    hourly_rate numeric(10,2) DEFAULT 0.00,
    date_hired date DEFAULT CURRENT_DATE,
    is_active boolean DEFAULT true
);
    DROP TABLE public.employees;
       public         heap r       postgres    false    857    4    857            �            1259    16419    employees_id_seq    SEQUENCE     �   CREATE SEQUENCE public.employees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.employees_id_seq;
       public               postgres    false    4    218            �           0    0    employees_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;
          public               postgres    false    217            �            1259    16526    leaves    TABLE       CREATE TABLE public.leaves (
    id integer NOT NULL,
    employee_id integer,
    leave_type public.leave_reason_type DEFAULT 'other'::public.leave_reason_type,
    leave_status public.leave_status_type DEFAULT 'pending'::public.leave_status_type,
    reason text
);
    DROP TABLE public.leaves;
       public         heap r       postgres    false    881    878    878    4    881            �            1259    16525    leaves_id_seq    SEQUENCE     �   CREATE SEQUENCE public.leaves_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.leaves_id_seq;
       public               postgres    false    226    4            �           0    0    leaves_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.leaves_id_seq OWNED BY public.leaves.id;
          public               postgres    false    225            �            1259    16440    projects    TABLE     "  CREATE TABLE public.projects (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    client_name character varying(255),
    start_date date DEFAULT CURRENT_DATE,
    end_date date,
    project_status public.status DEFAULT 'ongoing'::public.status,
    description text
);
    DROP TABLE public.projects;
       public         heap r       postgres    false    863    863    4            �            1259    16439    projects_id_seq    SEQUENCE     �   CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.projects_id_seq;
       public               postgres    false    4    220            �           0    0    projects_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;
          public               postgres    false    219            �            1259    16464    tasks    TABLE       CREATE TABLE public.tasks (
    id integer NOT NULL,
    project_id integer,
    name character varying(255) NOT NULL,
    description text,
    assigned_to integer,
    task_status public.task_status_type DEFAULT 'todo'::public.task_status_type,
    deadline date
);
    DROP TABLE public.tasks;
       public         heap r       postgres    false    869    869    4            �            1259    16463    tasks_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.tasks_id_seq;
       public               postgres    false    4    222            �           0    0    tasks_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;
          public               postgres    false    221            �            1259    16489    working_logs    TABLE     *  CREATE TABLE public.working_logs (
    id integer NOT NULL,
    employee_id integer,
    project_id integer,
    work_date date DEFAULT CURRENT_DATE,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    total_hours numeric(5,2),
    description text
);
     DROP TABLE public.working_logs;
       public         heap r       postgres    false    4            �            1259    16488    working_logs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.working_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.working_logs_id_seq;
       public               postgres    false    224    4            �           0    0    working_logs_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.working_logs_id_seq OWNED BY public.working_logs.id;
          public               postgres    false    223            �           2604    16545 
   clients id    DEFAULT     h   ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);
 9   ALTER TABLE public.clients ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    227    228    228            �           2604    16423    employees id    DEFAULT     l   ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);
 ;   ALTER TABLE public.employees ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    217    218    218            �           2604    16529 	   leaves id    DEFAULT     f   ALTER TABLE ONLY public.leaves ALTER COLUMN id SET DEFAULT nextval('public.leaves_id_seq'::regclass);
 8   ALTER TABLE public.leaves ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    226    225    226            �           2604    16443    projects id    DEFAULT     j   ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);
 :   ALTER TABLE public.projects ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    219    220    220            �           2604    16467    tasks id    DEFAULT     d   ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);
 7   ALTER TABLE public.tasks ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    221    222    222            �           2604    16492    working_logs id    DEFAULT     r   ALTER TABLE ONLY public.working_logs ALTER COLUMN id SET DEFAULT nextval('public.working_logs_id_seq'::regclass);
 >   ALTER TABLE public.working_logs ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    223    224    224            �          0    16542    clients 
   TABLE DATA                 public               postgres    false    228   �C       �          0    16420 	   employees 
   TABLE DATA                 public               postgres    false    218   �D       �          0    16526    leaves 
   TABLE DATA                 public               postgres    false    226   �F       �          0    16440    projects 
   TABLE DATA                 public               postgres    false    220   �G       �          0    16464    tasks 
   TABLE DATA                 public               postgres    false    222   �H       �          0    16489    working_logs 
   TABLE DATA                 public               postgres    false    224   9J       �           0    0    clients_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.clients_id_seq', 3, true);
          public               postgres    false    227            �           0    0    employees_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.employees_id_seq', 10, true);
          public               postgres    false    217            �           0    0    leaves_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.leaves_id_seq', 6, true);
          public               postgres    false    225            �           0    0    projects_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.projects_id_seq', 3, true);
          public               postgres    false    219            �           0    0    tasks_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.tasks_id_seq', 6, true);
          public               postgres    false    221            �           0    0    working_logs_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.working_logs_id_seq', 6, true);
          public               postgres    false    223            �           2606    16549    clients clients_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.clients DROP CONSTRAINT clients_pkey;
       public                 postgres    false    228            �           2606    16431    employees employees_email_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_email_key UNIQUE (email);
 G   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_email_key;
       public                 postgres    false    218            �           2606    16429    employees employees_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_pkey;
       public                 postgres    false    218            �           2606    16535    leaves leaves_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.leaves
    ADD CONSTRAINT leaves_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.leaves DROP CONSTRAINT leaves_pkey;
       public                 postgres    false    226            �           2606    16449    projects projects_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.projects DROP CONSTRAINT projects_pkey;
       public                 postgres    false    220            �           2606    16472    tasks tasks_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.tasks DROP CONSTRAINT tasks_pkey;
       public                 postgres    false    222            �           2606    16497    working_logs working_logs_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.working_logs
    ADD CONSTRAINT working_logs_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.working_logs DROP CONSTRAINT working_logs_pkey;
       public                 postgres    false    224                       2606    16536    leaves leaves_employee_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.leaves
    ADD CONSTRAINT leaves_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.leaves DROP CONSTRAINT leaves_employee_id_fkey;
       public               postgres    false    3315    226    218            �           2606    16478    tasks tasks_assigned_to_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.employees(id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY public.tasks DROP CONSTRAINT tasks_assigned_to_fkey;
       public               postgres    false    218    3315    222            �           2606    16473    tasks tasks_project_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.tasks DROP CONSTRAINT tasks_project_id_fkey;
       public               postgres    false    220    222    3317                        2606    16498 *   working_logs working_logs_employee_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.working_logs
    ADD CONSTRAINT working_logs_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(id) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.working_logs DROP CONSTRAINT working_logs_employee_id_fkey;
       public               postgres    false    3315    218    224                       2606    16503 )   working_logs working_logs_project_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.working_logs
    ADD CONSTRAINT working_logs_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE SET NULL;
 S   ALTER TABLE ONLY public.working_logs DROP CONSTRAINT working_logs_project_id_fkey;
       public               postgres    false    224    220    3317            �     x���Mk�@�����قJ՘z1	B��B�z��Y��;���w7�-���0eŊ�ʪ~�~���G\
Td`��}� ��q��޷3׊N9Y�-�����4�e�p�\=�7(��p� ��V�o�ĳ����u�T�#�r�f�{=P��h,�ʬ��p���4�/2S��#	����v�J�oX�0�
�S?�tIm�+�b��
�:輳�[pUɲ,�~��o�Ά���؟�6�����6��6����?�~X      �   �  x��SMS�0��+zCgL&I���"(*�⌠�S��4L��{�U*~��%�l�����h<��D���:Z<�&�Rmƭ�.�����`��݃#݆Ņˊ��T���5p��05�:��3���[h�XR� LĄ�.\�g�{����K�ݱ͗.R��7��V�!�JFY�+����@>Δ7y����58��1�"���f6�[���	�� �ʔ��� �D��3|�>7&W��"H_+d��,d���c�K �U��� ����M�K��4��sNx����|�U�/_���l{��a���Y�$d�w�j'@>�j=�z5�a�?�zm�6�Nbִ�]`��¯�u�|�#C�Z��|��G��� K�jcB�'je\�>�P���3'��Z�i(ϑ}����b�}��#`TU��.����x#�j�.%u�      �   �   x���KK�0�}��U!���,*d����Nr;�$�>��{����&�/�r�+��M��0�����;��_�N�.�4�ֻ<����M�冀̈́�g�t$k�ӻ��W��uT:�ߓ��3� gP�Ȣ��(��04u�u��K��Y��;jm�����_�h��㼌�R�j��7��}��3�ã����Y�i^f�6n���R�� >,$W
��;޲������� �)�Y�oͦ�      �   �   x����N�0��<�m	�ء00��HPP��u���k[�����Ft���~K����\VŪ�rY���J�[��
��z��YTpEo �඗a����i��Qt�l�Y��HFÛ�=ɳ��n��m��!��DX7��ϡ �~L��X�D!w#�Cq�3n;�f����y���z tvf��ߨ�� �'�=b/������an�ۼa#!O���(#��NO�T���AH�����K��S���J��      �   d  x��RMO�0��W�V�(���8�m�Jh�"�Y��ڤj��~��0BT�"%~�{~v�٭_��n����C%�[��I���)[��*�:A��
�(d@�e�� ��T56�@`�CE��t�����	M����	�(��Q&���a��'"�EY~B�YlSWd�g�T̒iDΌP�Sb5�P3IBj
�cJ2����qO)���u�l��JW6k*Ÿ+��M�΂���G�G2̶H��_fL�8$e��Qg��d��(�mn�eq��x���>�a�S�܊v .ء���q�&���0��X3��	�+0ȿ{Ń�g��V�\nչ�ѽ����E+ڀ#"?Ю�����Y��h�I�}      �   ;  x���=o�0�w~�mi���@B�j"��h���G�H�(qҿ_۠�Q�F�p���y�.^,�+��W(�MƓ��,�\�ߙL+��=��K��\8�'��O��8�F&SB�1�7n�h@�~��_!)`Ê�����̱�):������[93�����LZ��j�B�*��foq�F.����揦Ö����E���j~�J��LR[��.;��0�2��@�����Q
V'��>����v��Бm�����)wp��i�`�Ϛ���Zu
ک_(L,ֻX�a�*�P�f�4����W`�v��lC�����~�f�}     